# -*- coding: utf-8 -*-
"""
Charles Map Local XML 生成器
===========================
读取 maplocal_rules.py 中的规则 + 扫描测试桩/ 目录
自动生成完整的 MapLocal.xml，可直接 Import 到 Charles

用法：
    python generate_maplocal.py
    python generate_maplocal.py -o 输出路径
"""

import os, sys, argparse
import xml.etree.ElementTree as ET
from xml.dom import minidom
from datetime import datetime

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import maplocal_rules as rules

PROJECT_DIR  = r"D:\WorkCode\DP\DP_AutoTest\IPTV_HENANYD_72"
STUB_DIR     = os.path.join(PROJECT_DIR, "测试桩")
DEFAULT_OUT  = os.path.join(os.path.expanduser("~"), "Desktop",
    f"Map Local_auto_{datetime.now().strftime('%Y%m%d_%H%M%S')}.xml")

def scan_files(d):
    if not os.path.isdir(d): return set()
    ignore = {"Block List.xml", "Map Remote.xml", "Rewrite.xml",
              "Charles Settings.xml", "null", "MapLocal.xml"}
    return {f for f in os.listdir(d)
            if os.path.isfile(os.path.join(d, f)) and f not in ignore
            and not f.startswith("_") and not f.startswith("Map Local")}

def process_file(filename, stub_dir):
    dest = os.path.join(stub_dir, filename)
    bname = filename.rsplit(".", 1)[0]
    ext = os.path.splitext(filename)[1].lower()
    is_img = ext in rules.IMAGE_EXTENSIONS

    # ── 1) 特殊规则 ──
    if is_img:
        if bname.startswith("引导") and bname[2:].isdigit():
            return ("/yingdao" + bname[2:] + ".jpg", "", "127.0.0.1", dest)
        if filename.startswith("VIP模板_"):
            m = {"海报1":"haibao1","海报2":"haibao2","海报3":"haibao3",
                 "海报1_背景":"vip_beijing1","海报2_背景":"vip_beijing2","海报3_背景":"vip_beijing3",
                 "海报1_展示图":"vip_zhanshitu1","海报2_展示图":"vip_zhanshitu2","海报3_展示图":"vip_zhanshitu3",
                 "查看权益1":"chakanquanyi1","查看权益2":"chakanquanyi2",
                 "任务中心1":"renwuzhongxing1","任务中心2":"renwuzhongxing2",
                 "全员福利1":"huiyuanfuli1","全员福利2":"huiyuanfuli2"}
            s = bname.replace("VIP模板_", "")
            for k, v in m.items():
                if s == k or s.startswith(k):
                    return ("/" + v + ".jpg", "", "127.0.0.1", dest)
            return ("/vip_" + s + ".jpg", "", "127.0.0.1", dest)
        # IMAGE_PATH_MAP 查找
        if filename in rules.IMAGE_PATH_MAP:
            return (rules.IMAGE_PATH_MAP[filename], "", "127.0.0.1", dest)
        # fallback: 文件名
        return ("/" + filename, "", "127.0.0.1", dest)

    # ── 2) API 规则 ──
    # 先尝试完整文件名（不含ext），再试 prefix
    noext = filename.rsplit(".", 1)[0]
    candidates = []
    # 字典按key长度降序排列以确保最长匹配优先
    for k in rules.API_RULES:
        if noext.startswith(k):
            candidates.append((len(k), k))
    candidates.sort(reverse=True)
    if candidates:
        best_key = candidates[0][1]
        path, qt = rules.API_RULES[best_key]
        if qt is None:
            q = ""
        elif "{s}" in qt:
            sfx = noext[len(best_key):]
            if sfx.endswith(".json"): sfx = sfx[:-5]
            q = qt.replace("{s}", sfx) if sfx else ""
        else:
            q = qt
        return (path, q, None, dest)

    print(f"  [SKIP] {filename}")
    return None

def make_xml(files, stub_dir):
    root = ET.Element("mapLocal")
    ET.SubElement(root, "toolEnabled").text = "true"
    mappings = ET.SubElement(root, "mappings")

    api_n = img_n = 0
    for fname in sorted(files):
        r = process_file(fname, stub_dir)
        if r is None: continue
        path, q, host, dest = r

        # 分类计数
        if q or host is None:
            api_n += 1
        else:
            img_n += 1

        b = ET.SubElement(mappings, "mapLocalMapping")
        sl = ET.SubElement(b, "sourceLocation")
        ET.SubElement(sl, "protocol").text = "http"
        if host: ET.SubElement(sl, "host").text = host
        ET.SubElement(sl, "path").text = path
        if q: ET.SubElement(sl, "query").text = q
        ET.SubElement(b, "dest").text = dest
        ET.SubElement(b, "enabled").text = "true"
        ET.SubElement(b, "caseSensitive").text = "false"

    total = len(mappings)
    # 美化
    raw = ET.tostring(root, encoding="UTF-8")
    dom = minidom.parseString(raw)
    pretty = dom.toprettyxml(indent="  ", encoding="UTF-8").decode("UTF-8")
    lines = [l for l in pretty.split("\n") if not l.startswith("<?xml")]
    xml_out = '<?xml version="1.0" encoding="UTF-8"?>\n' \
              '<?charles serialisation-version="2.0"?>\n' + "\n".join(lines)
    return xml_out, total, api_n, img_n

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("-o", "--output", default=DEFAULT_OUT)
    ap.add_argument("-d", "--dir", default=STUB_DIR)
    args = ap.parse_args()

    print("=" * 60)
    print(" Charles Map Local XML 生成器")
    print("=" * 60)

    files = scan_files(args.dir)
    known = {"Block List.xml","Map Remote.xml","Rewrite.xml","Charles Settings.xml","null","MapLocal.xml"}
    files -= known
    print(f"\n  [扫描] {args.dir} -> {len(files)} 个文件")

    xml_content, total, api_n, img_n = make_xml(files, args.dir)

    os.makedirs(os.path.dirname(args.output) or ".", exist_ok=True)
    with open(args.output, "w", encoding="UTF-8") as f:
        f.write(xml_content)

    print(f"\n  [输出] {args.output}")
    print(f"    API/接口规则: {api_n}")
    print(f"    图片/静态资源: {img_n}")
    print(f"    总计: {total}")
    print(f"\n  打开 Charles -> Tools -> Map Local -> Import")
    print(f"  选择该文件即可")

if __name__ == "__main__":
    main()
