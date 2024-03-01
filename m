Return-Path: <tobias.schaffner@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C52C5478C
	for <webhook@archiver.kernel.org>; Fri,  1 Mar 2024 12:12:54 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.57])
 by mx.groups.io with SMTP id smtpd.web11.21219.1709295167371320532
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Mar 2024 04:12:48 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=S0qqNQaD;
 spf=pass (domain: siemens.com, ip: 40.107.20.57, mailfrom: tobias.schaffner@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5ydAYW2Uub/U3zIvFCwD0gK/3CwoZxGgO1zS/HkAUFqGXf07a809fuWnQMfiELr9O/hClnCG5nyDOyhqaf/3nHKNGuYiS09dkzX87xQzyapeacPfd6d0Ha+hjoPCUc8kSalN/W7iAFjziLzJ2seIOYreRgu0Rqjv3QtzO9gnt6rnCVrFYyZergarC1oi96YByfJdzQlgtMeLjmzmjxMo+PMWCJ0deMMlVkdlfpGpmcfF7g2MSWjkTc2MpOay+5lEib0wqhqfvQr3YxfAkb/jZOWpDxStii1SSa2Qg0Dp4NzqP63YmUczl5NLbRrTjSYsV9yqrXIdtBGAagGo1QDNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4nxEjb1ZMm1O4s9OkB0lt5F5MH7HPmqMKcFCmNh3IY=;
 b=WMnnQuX5gmEOlQk9nPjtiBw1VcEdzhyZyvkqHH3SxT6H5rJttNx9B7c4oqvcROd4OSNpJhqVVBkokcF9pc3xkhkRToIdOurIKBVHTz9++7+0W/dZhvq42vc54MuytlEhM/lyKuIYfAuoqHPAG2terwNhCF90Vlk5QkeZMUQoa/+V9ZL0e7Ft554eb4v+GF4t2u9jyQPZ5Zzwjr6R21iqr1f6GYU5Kby5amuoK+/MP7/k4/e4NJL85rtBArwvJ+oS5+sGOoRLQ/11xzyg5BNeWxPuomrZNzN2HqgeAWasN+mfQk1GMAJNh3D6xN+J+ISYEs4PjQgVmDwasI0rYUS0hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4nxEjb1ZMm1O4s9OkB0lt5F5MH7HPmqMKcFCmNh3IY=;
 b=S0qqNQaD7DcvvYMhEKRee/d6JRthJL0zY+FeV1tPbdnIr0nPyAKpXDmVeBSFBPh0/d/DK9MJU0/kbG7gz1AwJeZL7BE4yhwKCPosOwhO5SZVK0+MwufFRLtw0L2kbbCiu+TcDGYHQ0Nqbkj4bn25RTE4KGReoC+xG9+6K2lSX6Uh7mkx51AHZ7pB+SRpoNzXMJ/XQ0VJsf4DjajHHphBDFcDqSuo+1o8ks4Vl6voZvcj9qzAvJ9OtTFavYLw4oEvojPEKfWRmfHVzwZte1ELtjsWIDrH8WL+KWqzmdD3IJ9Z3gRYh5ZmAOTBGAV9ZeWsdT4xWJChMfAMySC/mGvOsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by AS4PR10MB6231.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:58e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.40; Fri, 1 Mar
 2024 12:12:43 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b799:7904:7414:cd1c]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b799:7904:7414:cd1c%7]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 12:12:43 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: cip-dev@lists.cip-project.org
CC: Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH] swupdate_2021.11: Backport raw handler unmount fix
Date: Fri,  1 Mar 2024 13:12:41 +0100
Message-ID: <20240301121241.259677-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::18) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|AS4PR10MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e0b1ec-37ea-442c-2f22-08dc39e8e624
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	TwFnp8VbzAZBdePJx8S3etZvlWQadJ0th7p8unftD1oc4oQHfFNGaPrqaBzfzWQvM188DBSIHdgd3leaW+Mp4qCO7vdTXQ+w4RSFGbXUOsziYwGyeopt4MJX70oOevsZVTb/NYV/toqADmdjD7NSS6v19HYsuu/gkIYCqw1JDbbWtV4HCpDf8+0C+jv9bp/KWz2piirgg1CI5aKMfyVDDuyS/T2iZg3Vvjm0e3C4XHC23WO2UNb7cEqq52jVlAmPhwZZN/wnojWI0/51n103rBuGClRPWdtTQXwGpuKcI5JvQKKvBa0vjU0/HCDl3PhNXhWskXjlw0SuxW23DhQw2jlO5mV2tDekrd/JZ0HhAiBK27JYVy9Lj+cVRgxCxOIGzDsmrFzvyXD5tCphs4j3hdjgi5ZLiD4ADhLcxw+yF7Bq/PFAGbTvo6fb0J7qk2ZodrO3rq/ZXlbYYIYKgaBuSujeaxMvtjMbluuUD5xJFa26+5msAFxDlFvctNnWpYHoZpbDP+Jxi7Y9S7bOYfnozXbbM2bveBISDDpUGKrnP0e4jP0I5WhAStcQmhfsg7N7rMxvbWUuIMnRwR1okRdeRv/CXDfMJCS0Y1l/oZk8CxNdaCoETkHTPBH6JsIgHDci2vd7iE3OrNuC+d7Izuyhug==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ocbz+9clO9c3BjUqJ9jLjiX4lJbqcEsITg33l3BzTpwlYDy+pE0CuJHG1S+f?=
 =?us-ascii?Q?Zr6MMkZPYdB8HYPduPBR4nwG4TEBgFtcCCzzazQoyRbHo/3AMUpjYnT7QOVd?=
 =?us-ascii?Q?f/yQoVOmgKSqkfCQgINQ1VgwRuu+3qQewcxVTX6bupr1ZJnHPUe1kHBn+kKh?=
 =?us-ascii?Q?KGEiQ33p/4PHCcJZUCgrHhJegSzGbnm7fBGD+e2rUk/rzOH8IQYQ1rpLURB8?=
 =?us-ascii?Q?NRdcCrukUy06ZHWWpVZMP0CdGhfRz+u+k96WM42XTGXtWQDnej5Vd+WDpapW?=
 =?us-ascii?Q?TDEfoO0g+Jp29f1wgKjiQCRYrslD8ohRG7vJqwNMhjG9hPVp/np7xMyOB5dr?=
 =?us-ascii?Q?081ROFMsr1WfArAzdxK/8F/vbFOaALq34j3yxpF3OfaAOKAWZMTzrVCJmM7i?=
 =?us-ascii?Q?57zvOfV3soqKU6tn8AiM861v0fL6GOoQVfM2Z/3GRicVnoemFVVmIfZXj65N?=
 =?us-ascii?Q?8v0LRddrfv314yUvTVkaDWj9Y66A6UxrTMcTzI/2S2unQjQbTfmtYmu6EgrR?=
 =?us-ascii?Q?GyVCIDoKumi/tuHkTWRJidkkkBj3pHEx0GWVAPUHevsZ5u2QAlUQUi7c8Ao1?=
 =?us-ascii?Q?JXIPxxZo/mNHVP7UfVOwVf6vX06a1EbOYoBGdsrYtnLt0lkbzpoSJJjHDUdc?=
 =?us-ascii?Q?ywa8OaaqZLuTPjWQNlUHoOX2E4ZXtQ5Pa6cYLi7mO/WQ9x9z+rKxerJpfEaA?=
 =?us-ascii?Q?3xSQ8O0bxfS7VXIxXXoDcloH3+Xii3WVP7i0WUNc0wOXGFEEqA3Larlt2X0J?=
 =?us-ascii?Q?OJnQPSPlA3JpYZbLg3c+C2tg/uWdr7QFIsa8JMxtv1cTqcxIF9Y+tOoPUmcr?=
 =?us-ascii?Q?TzuFQEtcro6bplrK8MyiFLnLZbfLrWxB37J+R0TpfmQmuhX/O81j/WkYRwdX?=
 =?us-ascii?Q?dY7vLV32S4br+mHWyE0lZxfBL/Qi6WKx4It9Ayujl1GszX3rjAe4ZppRP7GL?=
 =?us-ascii?Q?gO3lF7GbYDPAwbCy7qz3aGcpiVY0yoV9VrXSFCrbIk3DMRzreuS1MRlXCuac?=
 =?us-ascii?Q?5ZNxgW5NiIe3hUir2ZjmlrLrLzv616nzSeUZ1gxJnrCMQ68IpvE7WeLCOzAP?=
 =?us-ascii?Q?fhlqWAW8DdMhSExYEvHBN/hgE5ILamA0xVFFaNG24cSc0hsM7/ANUs3Z0TuJ?=
 =?us-ascii?Q?UsRgM+57Fh0NSC4jEkR4acAXUP6qnpNgJI0DrvKOsshVdHHn5z0e8Tu2lxdj?=
 =?us-ascii?Q?EuEBypwUxNJbYcjj9FCUUjXrPRuRXrOPgiCXUzz763gafBFSFLEVCcfQX/Ry?=
 =?us-ascii?Q?mZmwLJA1aEhn8nYIAnakRAUbHXPPHyjCWSw+pngqjnZ1opNrhHYhIDqAW/RH?=
 =?us-ascii?Q?KYhyTkxEG2LktkAKUU6+wIbBZvPPh0CvLoz8vjZyUlHIrLEUNRURbzWTE70x?=
 =?us-ascii?Q?YiX23ZvAw2V5U/4QcIXLE8vjWiQzptp01zBBxcuDkAOjksDk4rOl+HUNRjIl?=
 =?us-ascii?Q?YFss0+SyfmUg/Kd5gAMyOx2zbZVDqfka2apN9k1eozYTO0r0guqYtHxnImZE?=
 =?us-ascii?Q?LtVjmcUzQyvu0wLY9xzBHHTG9zoj3y6bvrXbGhBMkYwt3ai2rYEoBM1yft6P?=
 =?us-ascii?Q?X0S65NWFBbKt6IO2WhX1zDYk3vsjzWp22lHDPe3gpvbGx+Y4MnALIhZUR1dT?=
 =?us-ascii?Q?S3m+ArTTvhtoorfvsBIVUSdPFT+FLH+zrbF2PchPPhiM1PYHrm3yMYDCRr0B?=
 =?us-ascii?Q?BAGvvQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e0b1ec-37ea-442c-2f22-08dc39e8e624
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 12:12:43.6957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F68RXAEsPtTfzRe8C9cQ/qeJ4W9niTGVzH3TK8LBDMUHGZaWtPEaG9piSy77EoCnpubBe6pz96WXJyjW1ZziOCEzJBMkZruxSxiAnYyChyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6231
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Mar 2024 12:12:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15115

Swupdate 2021.11 has a bug that clears the boot partition if installing
a kernel file fails. On error the boot partition will stay mounted to a
directory in /tmp which will be recursively cleared.
This is critical if A/B partitioning with efibootguard is used as the ebg
environment will be destroyed making it impossible to do further updates.

Backport efc06332bb0bd622e6b542e0d3bd15135629d06a to fix this issue.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 ...ian-backport-raw-handler-unmount-fix.patch | 165 ++++++++++++++++++
 .../swupdate/swupdate_2021.11-1+debian-gbp.bb |   3 +-
 2 files changed, 167 insertions(+), 1 deletion(-)
 create mode 100644 recipes-core/swupdate/files/2021.11/0006-debian-backpor=
t-raw-handler-unmount-fix.patch

diff --git a/recipes-core/swupdate/files/2021.11/0006-debian-backport-raw-h=
andler-unmount-fix.patch b/recipes-core/swupdate/files/2021.11/0006-debian-=
backport-raw-handler-unmount-fix.patch
new file mode 100644
index 0000000..fdea66c
--- /dev/null
+++ b/recipes-core/swupdate/files/2021.11/0006-debian-backport-raw-handler-=
unmount-fix.patch
@@ -0,0 +1,165 @@
+From faae516d5c06dc13b953002fd91c0ba3e9bba7d8 Mon Sep 17 00:00:00 2001
+From: Tobias Schaffner <tobias.schaffner@siemens.com>
+Date: Thu, 15 Feb 2024 10:43:12 +0100
+Subject: [PATCH] Backport raw handler unmount fix
+
+Swupdate 2021.11 has a bug that clears the boot partition if installing
+a kernel file fails. On error the boot partition will stay mounted to a
+directory in /tmp which will be recursively cleared.
+This is critical if A/B partitioning with efibootguard is used as the ebg
+environment will be destroyed making it impossible to do further updates.
+
+Backport efc06332bb0bd622e6b542e0d3bd15135629d06a to fix this issue.
+
+Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
+---
+ ...nmount-target-device-when-installing.patch | 128 ++++++++++++++++++
+ debian/patches/series                         |   1 +
+ 2 files changed, 129 insertions(+)
+ create mode 100644 debian/patches/0002-raw-handler-Unmount-target-device-=
when-installing.patch
+
+diff --git a/debian/patches/0002-raw-handler-Unmount-target-device-when-in=
stalling.patch b/debian/patches/0002-raw-handler-Unmount-target-device-when=
-installing.patch
+new file mode 100644
+index 00000000..f291a8bd
+--- /dev/null
++++ b/debian/patches/0002-raw-handler-Unmount-target-device-when-installin=
g.patch
+@@ -0,0 +1,128 @@
++From d843a97aa56817c2c48dfb4f4b50315cdf753328 Mon Sep 17 00:00:00 2001
++From: Sava Jakovljev <savaj@meyersound.com>
++Date: Wed, 31 May 2023 23:44:22 +0200
++Subject: [PATCH] raw handler: Unmount target device when installing a fil=
e
++ fails
++
++Make sure to call 'swupdate_umount' in every scenario in
++'install_raw_file' function - this patch thus solves
++problems when an update fails on installing a file, and next update
++cannot be done because 'swupdate_mount' function fails with message
++"already mounted" because the  mount is still there from the previous
++attempt.
++
++Signed-off-by: Sava Jakovljev <savaj@meyersound.com>
++Signed-off-by: Stefano Babic <sbabic@denx.de>
++---
++ handlers/raw_handler.c | 65 +++++++++++++++++++++++++++++++-----------
++ 1 file changed, 49 insertions(+), 16 deletions(-)
++
++diff --git a/handlers/raw_handler.c b/handlers/raw_handler.c
++index 619a2f47..ac6a2030 100644
++--- a/handlers/raw_handler.c
+++++ b/handlers/raw_handler.c
++@@ -206,8 +206,9 @@ static int install_raw_file(struct img_type *img,
++ 	void __attribute__ ((__unused__)) *data)
++ {
++ 	char path[255];
++-	int fdout;
++-	int ret =3D 0;
+++	char tmp_path[255];
+++	int fdout =3D -1;
+++	int ret =3D -1;
++ 	int use_mount =3D (strlen(img->device) && strlen(img->filesystem)) ? 1 =
: 0;
++ 	char* DATADST_DIR =3D alloca(strlen(get_tmpdir())+strlen(DATADST_DIR_SU=
FFIX)+1);
++ 	sprintf(DATADST_DIR, "%s%s", get_tmpdir(), DATADST_DIR_SUFFIX);
++@@ -228,7 +229,7 @@ static int install_raw_file(struct img_type *img,
++ 		if (snprintf(path, sizeof(path), "%s%s",
++ 					 DATADST_DIR, img->path) >=3D (int)sizeof(path)) {
++ 			ERROR("Path too long: %s%s", DATADST_DIR, img->path);
++-			return -1;
+++			goto cleanup;
++ 		}
++ 	} else {
++ 		if (snprintf(path, sizeof(path), "%s", img->path) >=3D (int)sizeof(pat=
h)) {
++@@ -237,35 +238,67 @@ static int install_raw_file(struct img_type *img,
++ 		}
++ 	}
++=20
++-	TRACE("Installing file %s on %s",
++-		img->fname, path);
+++	if (strtobool(dict_get_value(&img->properties, "atomic-install"))) {
+++		if (snprintf(tmp_path, sizeof(tmp_path), "%s.tmp", path) >=3D (int)siz=
eof(tmp_path)) {
+++			ERROR("Temp path too long: %s.tmp", img->path);
+++			ret =3D -1;
+++			goto cleanup;
+++		}
+++	}
+++	else {
+++		snprintf(tmp_path, sizeof(tmp_path), "%s", path);
+++	}
+++	TRACE("Installing file %s on %s", img->fname, tmp_path);
++=20
++ 	if (strtobool(dict_get_value(&img->properties, "create-destination"))) =
{
++ 		TRACE("Creating path %s", path);
++-		fdout =3D mkpath(dirname(strdupa(path)), 0755);
++-		if (fdout < 0) {
+++		ret =3D mkpath(dirname(strdupa(path)), 0755);
+++		if (ret < 0) {
++ 			ERROR("I cannot create path %s: %s", path, strerror(errno));
++-			return -1;
+++			goto cleanup;
++ 		}
++ 	}
++=20
++-	fdout =3D openfileoutput(path);
++-	if (fdout < 0)
++-		return fdout;
+++	fdout =3D openfileoutput(tmp_path);
+++	if (fdout < 0) {
+++		ret =3D -1;
+++		goto cleanup;
+++	}
++ 	if (!img_check_free_space(img, fdout)) {
++-		return -ENOSPC;
+++		ret =3D -ENOSPC;
+++		goto cleanup;
++ 	}
++=20
++ 	ret =3D copyimage(&fdout, img, NULL);
++-	if (ret< 0) {
+++	if (ret < 0) {
++ 		ERROR("Error copying extracted file");
+++		goto cleanup;
++ 	}
++-	close(fdout);
++=20
++-	if (use_mount) {
++-		swupdate_umount(DATADST_DIR);
+++	if (fsync(fdout)) {
+++		ERROR("Error writing %s to disk: %s", tmp_path, strerror(errno));
+++		ret =3D -1;
+++		goto cleanup;
+++	}
+++
+++	if (strtobool(dict_get_value(&img->properties, "atomic-install"))) {
+++		TRACE("Renaming file %s to %s", tmp_path, path);
+++		if (rename(tmp_path, path)) {
+++			ERROR("Error renaming %s to %s: %s", tmp_path, path, strerror(errno))=
;
+++			ret =3D -1;
+++			goto cleanup;
+++		}
++ 	}
++=20
+++	ret =3D 0;
+++
+++cleanup:
+++	if (fdout > 0)
+++		close(fdout);
+++
+++	if (use_mount)
+++		swupdate_umount(DATADST_DIR);
+++
++ 	return ret;
++ }
++=20
++--=20
++2.34.1
++
+diff --git a/debian/patches/series b/debian/patches/series
+index 98628a77..21a82863 100644
+--- a/debian/patches/series
++++ b/debian/patches/series
+@@ -1,2 +1,3 @@
+ use-gcc-compiler.diff
+ 0001-bootloader-EBG-fix-do_env_get-for-anything-but-globa.patch
++0002-raw-handler-Unmount-target-device-when-installing.patch
+--=20
+2.34.1
+
diff --git a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb b/recip=
es-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
index 2384f41..5671cfa 100644
--- a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
+++ b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
@@ -25,7 +25,8 @@ SRC_URI +=3D "file://0001-debian-Remove-SWUpdate-USB-serv=
ice-and-Udev-rules.patch
             file://0002-debian-rules-Add-Embedded-Lua-handler-option.patch=
 \
             file://0003-debian-rules-Add-option-to-disable-fs-creation.pat=
ch \
             file://0004-debian-rules-Add-option-to-disable-webserver.patch=
 \
-            file://0005-debian-Add-patch-to-fix-bootloader_env_get-for-EBG=
.patch"
+            file://0005-debian-Add-patch-to-fix-bootloader_env_get-for-EBG=
.patch \
+            file://0006-debian-backport-raw-handler-unmount-fix.patch"
=20
 # If the luahandler shall be embedded into the swupdate binary
 # include the following lines.
--=20
2.34.1


