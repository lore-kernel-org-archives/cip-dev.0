Return-Path: <SRS0=HXZj=DC=lists.cip-project.org=bounce+64572+5478+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DFFC4363D
	for <cip-dev@archiver.kernel.org>; Fri, 25 Sep 2020 05:08:50 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2899208B6
	for <cip-dev@archiver.kernel.org>; Fri, 25 Sep 2020 05:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="eWkTyLDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2899208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5478+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ScfvYY4521723x0Vk04j09vT; Thu, 24 Sep 2020 22:08:49 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.783.1601010528282774349
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2020 22:08:48 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 08P585pk013427; Fri, 25 Sep 2020 14:08:06 +0900
X-Iguazu-Qid: 2wHHnVxnkEFv8KTXML
X-Iguazu-QSIG: v=2; s=0; t=1601010485; q=2wHHnVxnkEFv8KTXML; m=0f/99m+Z+HrsxHvHv42pR/9bDGAlWGUHdaOxDrObz2A=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1112) id 08P583l9020174;
	Fri, 25 Sep 2020 14:08:04 +0900
X-Received: from enc01.toshiba.co.jp ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 08P583sZ023192;
	Fri, 25 Sep 2020 14:08:03 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 08P5820x027724;
	Fri, 25 Sep 2020 14:08:03 +0900
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: sz.lin@moxa.com, ben.hutchings@codethink.co.uk, wens@csie.org
Cc: cip-dev@lists.cip-project.org
Subject: [cip-dev] [cip-kernel-sec] reports: add script to convert reports to csv format
Date: Fri, 25 Sep 2020 14:07:56 +0900
X-TSB-HOP: ON
Message-Id: <20200925050756.1960978-2-daniel.sangorrin@toshiba.co.jp>
In-Reply-To: <20200925050756.1960978-1-daniel.sangorrin@toshiba.co.jp>
References: <20200925050756.1960978-1-daniel.sangorrin@toshiba.co.jp>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: WWyXNiWmtmxBXFKXizR0U6otx4520388AA=
Content-Type: multipart/mixed; boundary="klzH6aVQARTEqWz8SwuA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1601010529;
 bh=CtjUNJTq/E1z0aZflVe91A0AE21hZKoQuf4q+jY3FcQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=eWkTyLDdTO9usYJP4gMPLFFgUb02QKD0V1vVvCxU6WEupRGcG43ruVczONSo3IzbfiM
 Luma1VA87suWQzN54OXpFM59YaOKQX5rt5NuWjQ4OE5Rh3oZeDnEM+frIex19hjZuecQK
 xa7YVOzoX/1RhHwCfJHgyFs8BZ28MX8ZS+s=

--klzH6aVQARTEqWz8SwuA
Content-Transfer-Encoding: 8bit

The text version is probably enough for developers but
customers usually prefer to have a CSV that you can
open with a spreadsheet program and contains additional
information. CVEs are sorted in rows according to their
criticality.
)
Example usage:
  $ ./scripts/report_affected.py stable/4.19 > security-report.txt
  $ ./scripts/report_to_csv.py \
      --security-report security-report.txt \
      --issues-dir issues

Signed-off-by: nguyen van hieu <hieu2.nguyenvan@toshiba.co.jp>
Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 scripts/report_to_csv.py | 262 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 262 insertions(+)
 create mode 100755 scripts/report_to_csv.py

diff --git a/scripts/report_to_csv.py b/scripts/report_to_csv.py
new file mode 100755
index 0000000..a3a984f
--- /dev/null
+++ b/scripts/report_to_csv.py
@@ -0,0 +1,262 @@
+#!/usr/bin/python3
+
+"""
+This script will parse the text output from report_affected.py
+(without options) and generate a CSV file that contains
+additional information extracted from the NVD database (json format)
+
+Example usage:
+  $ ./scripts/report_affected.py stable/4.19 > security-report.txt
+  $ ./scripts/report_to_csv.py \
+      --security-report security-report.txt \
+      --issues-dir issues
+"""
+
+import re
+import wget
+import os
+import sys
+import gzip
+import json
+import csv
+import filecmp
+
+DATABASE_DIR = os.getcwd() + "/nvd-data/"
+
+def parse_cmd():
+    """Parse command options.
+    """
+    import argparse
+
+    CURRENT_DIR = os.getcwd()
+    parser = argparse.ArgumentParser()
+    parser.add_argument('--security-report', dest='security_report', metavar='FILE',
+                      default=CURRENT_DIR + '/security-report.txt',
+                      help='Output from report_affected.py (without options)')
+    parser.add_argument('--issues-dir', dest='issues_dir', metavar='DIRECTORY',
+                      default=CURRENT_DIR + '/issues',
+                      help='directory containing the issues in YAML format')
+
+    args = parser.parse_args()
+    return args
+
+def download_file(src, file, bar=""):
+    """Re-download file when an error occurred due to network connection problem.
+    """
+    for i in range(3):
+        try:
+            wget.download(src, file, bar)
+            break
+        except:
+            pass
+
+    if not os.path.exists(file):
+        print("ERROR: Can't download %s" % src)
+        exit(1)
+
+def get_cves_database(years):
+    """Get NVD data (json format) from NVD Data Feeds
+    """
+    DATABASE_URL = "https://nvd.nist.gov/feeds/json/cve/1.1"
+
+    for year in years:
+        if not os.path.exists(DATABASE_DIR + year):
+            os.makedirs(DATABASE_DIR + year)
+
+        json_data = '/nvdcve-1.1-' + year + '.json.gz'
+        meta_data = '/nvdcve-1.1-' + year + '.meta'
+        # Download meta and database files if they don't exist
+        if not os.path.exists(DATABASE_DIR + year + meta_data):
+            download_file(DATABASE_URL + meta_data, DATABASE_DIR + year + meta_data)
+        else:
+            download_file(DATABASE_URL + meta_data, DATABASE_DIR + year + meta_data + '.new')
+            if filecmp.cmp(DATABASE_DIR + year + meta_data, DATABASE_DIR + year + meta_data + '.new'):
+                os.remove(DATABASE_DIR + year + meta_data + '.new')
+
+            # Update meta and database files if they have any modified
+            else:
+                os.rename(DATABASE_DIR + year + meta_data + '.new', DATABASE_DIR + year + meta_data)
+                if os.path.exists(DATABASE_DIR + year + json_data):
+                    os.remove(DATABASE_DIR + year + json_data)
+
+        if not os.path.exists(DATABASE_DIR + year + json_data):
+            download_file(DATABASE_URL + json_data, DATABASE_DIR + year + json_data)
+
+def get_severity(cve_id, cve_items):
+    """Parse NVD database to get the `severity` of each CVE
+    """
+    severity = ''
+    for cve_item in cve_items['CVE_Items']:
+        if cve_id == cve_item['cve']['CVE_data_meta']['ID']:
+            if 'baseMetricV3' in cve_item['impact']:
+                severity = cve_item['impact']['baseMetricV3']['cvssV3']['baseSeverity']
+            elif 'baseMetricV2' in cve_item['impact']:
+                severity = cve_item['impact']['baseMetricV2']['severity']
+            break
+    if not severity:
+        severity = "N/A"
+    return severity
+
+def get_description(cve_id, cve_items):
+    """Parse NVD database to get the `description` of each CVE
+    """
+    DEBIAN_TRACKER = "https://security-tracker.debian.org/tracker/"
+    description = ''
+    for cve_item in cve_items['CVE_Items']:
+        if cve_id == cve_item['cve']['CVE_data_meta']['ID']:
+            description = cve_item['cve']['description']['description_data'][0]['value']
+            break
+
+    # Get CVE's description from debian tracker if that CVE is RESERVED in NVD
+    if not description:
+        if os.path.exists(cve_id):
+            os.remove(cve_id)
+
+        download_file(DEBIAN_TRACKER + cve_id, cve_id)
+        try:
+            file = open(cve_id,'r')
+        except:
+            print("ERROR: Can't open CVE tracker file: %s" % cve_id)
+            exit(1)
+        content = file.read()
+        try:
+            description = re.search('Description.*?<td>(.*?)</td>',content).group(1)
+        except:
+            description = "N/A"
+        file.close()
+        os.remove(cve_id)
+    return description
+
+def parse_kernel_log(security_report):
+    """Parsing the security report text file to get list CVEs of each branch|tag
+    """
+    if not os.path.exists(security_report):
+        print("ERROR: the security report text file doesn't exist")
+        exit(1)
+    if os.stat(security_report).st_size == 0:
+        print("LOG: the security report text file is empty")
+        exit(1)
+
+    CVE_IDS = {}
+    with open(security_report, 'r') as file:
+        for line in file.read().splitlines():
+            if not line:
+                continue
+            try:
+                branch = line.split(':')[-2].replace("/", "_")
+                cve_list = line.split(':')[-1]
+
+                cves_by_year = {}
+                for cve in cve_list.split():
+                    year = cve.split('-')[1]
+                    if year not in cves_by_year.keys():
+                        cves_by_year[year] = []
+                    cves_by_year[year].append(cve)
+
+                if not branch or not cves_by_year:
+                    print("LOG: Don't have any CVEs in branch|tag: '%s'" % branch)
+                    break
+                if branch in CVE_IDS.keys():
+                    print("LOG: The branch|tag '%s' is duplicated in the security report text file" % branch)
+
+                CVE_IDS[branch] = cves_by_year
+            except:
+                print("ERROR: The format of the security report text file is incorrect")
+                exit(1)
+    return CVE_IDS
+
+def get_cve_info(issues_dir, cves_by_year):
+    """Get the list of CVE-ids from the output of report_affected.py,
+       and parse the information from the CVE*.yml issues.
+    """
+    import yaml
+    import subprocess
+
+    CVES = []
+    for year in cves_by_year.keys():
+        json_data = '/nvdcve-1.1-' + year + '.json.gz'
+        # Parse json data file to get the severity/description of CVE
+        try:
+            file = gzip.open(DATABASE_DIR + year + json_data, 'r').read()
+        except:
+            print("ERROR: Can't open json data file: %s" % json_data)
+            exit(1)
+        cve_items = json.loads(file)
+
+        for cve_id in cves_by_year[year]:
+            if not os.path.exists(issues_dir + "/" + cve_id + '.yml'):
+                print("ERROR: Issues directory or %s.yml doesn't exist" % cve_id)
+                exit(1)
+
+            with open(issues_dir + "/" + cve_id + '.yml', encoding='utf-8') as f:
+                description = ''
+                references = ''
+                comments = ''
+                introduced_by = ''
+                fixed_by = ''
+
+                cve_info = yaml.load(f, Loader=yaml.Loader)
+                if "description" in cve_info:
+                    description = cve_info["description"]
+                # get the description in NVD database or Debian tracker if it doesn't exist in .yml file
+                if not description or description.isspace():
+                    description = get_description(cve_id, cve_items)
+
+                severity = get_severity(cve_id, cve_items)
+
+                if "references" in cve_info:
+                    for str in cve_info["references"]:
+                        references += str + "\n"
+                else:
+                    references = "N/A"
+
+                if "comments" in cve_info:
+                    for key in cve_info["comments"]:
+                        comments += key + ": " + cve_info["comments"][key] + "\n"
+                else:
+                    comments = "N/A"
+
+                if "introduced-by" in cve_info:
+                    for key in cve_info["introduced-by"]:
+                        introduced_by += key + ": " + " ".join(cve_info["introduced-by"][key]).replace(',', '+') + "\n"
+                else:
+                    introduced_by = "N/A"
+                if "fixed-by" in cve_info:
+                    for key in cve_info["fixed-by"]:
+                        fixed_by += key + ": " + ", ".join(cve_info["fixed-by"][key]) + "\n"
+                else:
+                    fixed_by = "N/A"
+
+            CVES.append({'CVE-id': cve_id, 'Description': description,
+                        'Severity': severity, 'References': references,
+                        'Comments': comments, 'Introduced-by': introduced_by,
+                        'Fixed-by': fixed_by})
+    return CVES
+
+def generate_csv_report(CVES, file_name):
+    with open(file_name, mode='w') as csv_file:
+        # writing the header fields
+        headers = CVES[0].keys()
+        csvwriter = csv.DictWriter(csv_file, fieldnames=headers)
+        csvwriter.writeheader()
+
+        weight_severity = {"CRITICAL": 0, "HIGH" : 1, "MEDIUM" : 2, "LOW" : 3, "N/A": 4, "": 5}
+        sorted_CVES = sorted(CVES, key=lambda x: weight_severity[x['Severity'].upper()])
+        # Writing the contents
+        for data in sorted_CVES:
+            csvwriter.writerow(data)
+
+if __name__ == "__main__":
+    args = parse_cmd()
+
+    CVE_IDS = parse_kernel_log(args.security_report)
+
+    # Getting CVEs database from NVD
+    YEARS = {}
+    for branch in CVE_IDS.keys():
+        YEARS |= CVE_IDS[branch].keys()
+    get_cves_database(YEARS)
+
+    for branch, cves_by_year in CVE_IDS.items():
+        CVES = get_cve_info(args.issues_dir, cves_by_year)
+        generate_csv_report(CVES, "security-report-%s.csv" % branch)
-- 
2.25.1


--klzH6aVQARTEqWz8SwuA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5478): https://lists.cip-project.org/g/cip-dev/message=
/5478
Mute This Topic: https://lists.cip-project.org/mt/77073673/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--klzH6aVQARTEqWz8SwuA--
