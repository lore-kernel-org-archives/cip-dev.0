Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505FBC54E69
	for <webhook@archiver.kernel.org>; Mon, 18 Mar 2024 11:29:24 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.75])
 by mx.groups.io with SMTP id smtpd.web11.40834.1710761354994605066
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Mar 2024 04:29:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=G/JNjIdH;
 spf=pass (domain: siemens.com, ip: 40.107.105.75, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qh+TEXGCcAlLWONWqeLXIvoMgDsQJEMiLc9hGbRd4Swzo2Llz/sbO86kxDd81IWi5TbNyZrNfEHoxQnK4HQksDPG2iS99Ot7gzGK9d9XXylXEymsS/oA2bxEyNezRO882Il85ab9Ajkk8IQOoN6piJfByZIbY7W3DnDTnyD7AtKjt4sDHCsrKAl6s0lJ0xaXJ/Zqbu8VLlnK4x36ajLLch9mPHr7IPqc2rvnK5VvUjmEmsAcbXhIa7zP9PQdSDMpKid9TIotphguszFEEt2h9zPbKgTqip7SWtFwnUtuhkdKGUcFBxE4ze4Z05r/PgcTSJplXlGoHkNlNMb8RBsp4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcUiMAF7OvR5WbEFp0jr1q94sg5FMW6s5ZBa3Uj6vmQ=;
 b=eh2heREhLQW/Pg072HYablEweQE3JbJ/oVahHj6sqfhhbRQJNuZFK6Gn0FJffN39jUI8hs6PnG75s7XMuLJ05uqa//yhS5urZfq9OwzYscB7O3FwoQ89NAXQt4wIxoLVdjqrhs+nTGONG8odKM21PCnnfstjlRnIsLWae484/0KDPzc7BWHKWWRkDanFQMMgadJQb0FeAyUr0X/URfWXZfkQvbal62xHw3Cn0EuhIPghdVZe4T9qs6kowF853bIhEFtbQitRlHHGnwiQb91c/d2aqtgQ1lrIs+3UUFK4qi9B9pfWnfzzGRxJg+O2yBBxj/vLvQgMbbb63nF7ubkgTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcUiMAF7OvR5WbEFp0jr1q94sg5FMW6s5ZBa3Uj6vmQ=;
 b=G/JNjIdHJejBpPZtmsMoRZGhwisP4JXjR64KZqdW145f/deVHxfo2EaK4g1TcNo97Yw6EIgeGRaDaWa6ZSpnK9BToCE/WTMLXgD5lNQqZ4IaXO0kzQCzxcbK3ysym6XcqfWx+DnGN7FiGvbWRCRNXkDUXvWq4FwSJ+buxMiw6pl1XnpBi9/NCeoLHfR2LMlwWXnnSQ8W9Pv8EISEw8EAkMyF6srRar2r0oOMteFw5UjbbexopyOY7bGuDIq+kaRTSlfZdLkUIDwg8RacNjeHLGMbJPo1qf4wJOdOfgKNzLh6XmxpiLq0P+5bbEatlZj5DuFcD6RqYKRjrSPobqTulw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7289.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 11:29:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 11:29:11 +0000
Message-ID: <cbaed533-04e7-4414-a3cf-7f27537e9ce9@siemens.com>
Date: Mon, 18 Mar 2024 12:29:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 1/3] swupdate: Add recipe for
 2023.12.1
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20240314123736.1100948-1-Quirin.Gylstorff@siemens.com>
 <20240314123736.1100948-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240314123736.1100948-2-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: df54fbd3-c23a-4ae6-ba07-08dc473ea23f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DO916ObyThsQCX14hCPI4di/wxYeEWd2qwfq1iGJpEs+Z7CuAlPj11EVkEVYcF7fPSREZeWyXFsemSToQR6QkY5AqxjNdG/awAV4B7PJ2Q1HYweVR8yzrQJD4ia8xR1ojwkNz9rgwIEg8JdrubDIWoSNkgqlZg/Yh5jLEM1YtpCt8kPBuClYdklPib5Yf9mlPjt06EyAtV7EFm5L4bqVNBlsRM2KsuzGo4kU0LOW2nkFeVbqZko07ueojNeqczBjvIdmKEoaeHLxIpW15w5JD5fskdQE7aSgzW9HPspnc9wCfkTdau2so52zeAjK7F/MNrDGVIV0UoHvfIYhJwSUYWYe866nek2SeKPygSD+1XHJDe8ODYF+n4mBX7ZlyiZP7EYUU3JPc3OH4Pf6TNKgL1DIXvByHZutMgLqnGJIyw5Eg1KtyIcOxqIMYo+no7ZzGNugDBUziYcKxI03X9LXJyiHyK5lx3Mrzu5OUSi+x6D4DmYW+6fyEDKQkw+W88L1byQLRJoRdXFMNsF5rcVxlyg7UeOwPpjy8O+6wrNYxolSQjs8ZjkdX8h+ClqTM9nfgzXptO4ySEP3EQtMRDfgAlLyv1x6Fz4yTcjRjzsQets=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZkE2Mm9GOTlrV1NTWCtWN1pwWjgxVEZ5dHdCVmZQdU1ySEQvOHczWXdTNGg2?=
 =?utf-8?B?NUExVFZmeTZqU0RvRm9Ndm82UFBBOTRhMXBJRUcrYkphMkZ5ZE5iV3g2bzZM?=
 =?utf-8?B?Szd4c0lIdzV6TlAwc3dZSjhNQmN5Qkx6Uk1yM2daNTZHdzlwWkZWZUp3d1V5?=
 =?utf-8?B?QW9IUnlwejZGVzlmS0g0OWFmKzdoa0RBZlpmcngvR0FmeEtVemRaTVk1bk9t?=
 =?utf-8?B?c0ZXZG9SWUl3ZkM5OW41RjluNXo0ZThvRFhRUExmRjdOelN1ZHYrQWM5ZDFv?=
 =?utf-8?B?d291VWt4OG8xS0ZVYm9Hejh2M0pNS3ZaNHhPMTNNbmJTZDZ1b0hJRlBING1o?=
 =?utf-8?B?UjcwVlBUVVdjY3VvVTBvQlltSllNRU9zOUJ4NHVTWU5wNnVhR0tQbyt2L0dD?=
 =?utf-8?B?NEZoemt3SG9BOG0yYmFSLy9nWlBUd29HcjdMQ3p3YmJJREVna1UxRXRLTkRZ?=
 =?utf-8?B?RElzWWgvL1NZbTM0aDdYM2NkVlNkbzFiaTd3eGg2djhtdVZ4dXZMc2pvclp3?=
 =?utf-8?B?L1gxM3FCMEVxOCtlOHJzMVYvQnMydmNCYXVjQXM2RjRjZTRxakR5aU5Va21G?=
 =?utf-8?B?SUVCLzV1c1BlM21tK3RIc3VBQzFxbkNNOWthcm5vVUlhQWV3UlBKcVhWdVFE?=
 =?utf-8?B?ZjRscGdnam5rMHhBYWdNdE5Ub3BjKzZBRnE3dGFsWmhkM0hWM1E3eGhjRWdt?=
 =?utf-8?B?Z2RCMjJIa0dRT08rSGNqaEt4NWZ6SUpzWmN3QkJCRUJOdmR2eG10RDYyY09U?=
 =?utf-8?B?d3d4RW1TbXpiSDg4SjRZNjRxV1BQb2dJK2IxSk8xdzdTWENHSUhEYVNWS0xx?=
 =?utf-8?B?bHhVa0Z1Zjlna1NhWDllanQwVkZ1a3VvbERPRUNWUU15MHE5eWRCbmpkS1pN?=
 =?utf-8?B?b1lCdlJacStwcTZBVlM4UVFVK2xDZ28yekVSTVlQT2puZ2FnSGs3NW9Udkdq?=
 =?utf-8?B?ODFoY1hHWHg2aTBNSU1HOHBxbVdwTUpGZElXTUZaTGZqaHBxd05kQ2FDL05R?=
 =?utf-8?B?YTZGUVRHazJrcUd1bGxuZS9sT1RlR2I5djlzRThkRUdkM0FMUTZFajAwZG5m?=
 =?utf-8?B?d1Vuc2VvWnlpbDFyTk1DQWRZWi8zZWVOT0huM2p1dEZFVG1qTGR4SWVsZkZR?=
 =?utf-8?B?bmpiMWlrSGZCdUNESnh6ZHBFd2J5TmJYT3J5OG52NUtUaE82My9NN1RFZUJT?=
 =?utf-8?B?TzRTR3JvS1Y2ZFBqb0JzbVY5SWFUVEtFdW82M2w2SW03bWROM3NyK2xDb3Ux?=
 =?utf-8?B?Tm5hWVA3dmxpci9oTEdQTHV0VHNEWkkyVXlCaUtKVFYrd2dUeUR3Tm4zTWRU?=
 =?utf-8?B?UnV6REF0amt4WHB6bjVoSytDVWdmS3kvR2RremVMejNSS2xPNmpTOVZTTGlD?=
 =?utf-8?B?WVRpdVFWUmF5andSdmkvS0g3dmZkbytyMUIzakpQVFNqOHY4UDgrSzZKaERU?=
 =?utf-8?B?Mm0wTGs3ellReEo2TWJwQXlQK045aW83OEdFNjdZMzFDM003THoxQlk1UWUx?=
 =?utf-8?B?OHJmSTVSZzVDcnZDNFE4WEVhZk9iK3VJWlJoZG1RaUJKR25OK3BZWFlPNnZD?=
 =?utf-8?B?aGRaMk5NU2d2MUM1VmwyTWM1RW0vaEtpRjREZENQRHk5bXNhWTlsSC9OMHZM?=
 =?utf-8?B?ZmI3eG5EVWcwalRxZGluRVRCQnllT1VXL3diTHRHOTladHk3TmI3T25tWkNL?=
 =?utf-8?B?VWJ4MElqUTRqQ2lMZVQrUTE5RHZXV1lwei9PUUJONjVRcFVRVVBhSk9aNDh1?=
 =?utf-8?B?RVV6RGNaQk1IcWI1Z25xbkl0NTdrc21ML3lYOG9vVHlIRkc2dnJ0YzNHcHRt?=
 =?utf-8?B?QWFkZnFpdW9mSDVZY29FeDUzOWd6Y1daRGxVTmlzTnI2ZHRVaVlaeU5vKytW?=
 =?utf-8?B?U0JwelYvVFpITjNDd1BGaFdSbjk0bVMxaUtReTNScHNxY2NITS9BZXg1Rjdu?=
 =?utf-8?B?U3haWmt2T3ZxbFZ0K0VzeGhONmlDQ2lvNysxVGpDWVFYb1UrN1dGTVdVN0g1?=
 =?utf-8?B?VWJIUVBYQjNlaWQwMjJWdG9hYzJRMHFMZlhTeGpGdFlmOFV1WW9PdTJQTlhE?=
 =?utf-8?B?bVl6Ym8zSENDak5kSUNIWjc4YVV5Z0hnenBmREQ1czkzc0NuWGh0QUdnazBT?=
 =?utf-8?Q?xexHB8EC9Va/R4oTbu0W5F7sz?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df54fbd3-c23a-4ae6-ba07-08dc473ea23f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 11:29:11.6437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xv7j+y1MaWRf39Y0pFicq5eUxuaxEHRLNFEZW7WJlrO5Fp8JXXxk+3BxThvpDCQIm2rIsW22zH/Wx/cYWfCWEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7289
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Mar 2024 11:29:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15341

On 14.03.24 13:36, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This fixes an error with postinstall and also enables wfx by default
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  ...rate-build_profile-option-for-delta-.patch | 45 ++++++++++++++++
>  ...install-Fix-path-for-debian-bullseye.patch | 24 +++++++++
>  recipes-core/swupdate/swupdate_2023.12.bb     | 53 +++++++++++++++++++
>  3 files changed, 122 insertions(+)
>  create mode 100644 recipes-core/swupdate/files/2023.12/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch
>  create mode 100644 recipes-core/swupdate/files/2023.12/0002-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch
>  create mode 100644 recipes-core/swupdate/swupdate_2023.12.bb
> 
> diff --git a/recipes-core/swupdate/files/2023.12/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch b/recipes-core/swupdate/files/2023.12/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch
> new file mode 100644
> index 0000000..ddb700b
> --- /dev/null
> +++ b/recipes-core/swupdate/files/2023.12/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch
> @@ -0,0 +1,45 @@
> +From 616b1d8f28da86a4897d13b16cd182eea55f7d83 Mon Sep 17 00:00:00 2001
> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +Date: Thu, 15 Jun 2023 18:48:25 +0200
> +Subject: [PATCH 1/2] d/rules: Add seperate build_profile option for delta
> + update
> +
> +Delta update need zchunk 1.3 to work on memory restricted
> +devices. zchunk 1.3 is is not available in bullseye-backports
> +and Debian bookworm(12).
> +
> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +---
> + debian/control | 2 +-
> + debian/rules   | 2 +-
> + 2 files changed, 2 insertions(+), 2 deletions(-)
> +
> +diff --git a/debian/control b/debian/control
> +index 4f1b81a1..c5246aa6 100644
> +--- a/debian/control
> ++++ b/debian/control
> +@@ -28,7 +28,7 @@ Build-Depends: debhelper-compat (= 13),
> +                uuid-dev,
> +                zlib1g-dev,
> +                libzstd-dev,
> +-               libzck-dev (>= 1.3) <!pkg.swupdate.bpo>,
> ++               libzck-dev (>= 1.3) <pkg.swupdate.delta>,
> +                libp11-kit-dev <pkg.swupdate.p11>,
> +                libwolfssl-dev (>= 5),
> +                libmtd-dev [linux-any],
> +diff --git a/debian/rules b/debian/rules
> +index 4140257e..4e81bcae 100755
> +--- a/debian/rules
> ++++ b/debian/rules
> +@@ -38,7 +38,7 @@ ifeq (linux,$(DEB_HOST_ARCH_OS))
> + else
> + 	echo "# CONFIG_MTD is not set"     >> configs/debian_defconfig
> + endif
> +-ifeq (,$(filter pkg.swupdate.bpo,$(DEB_BUILD_PROFILES)))
> ++ifneq (,$(filter pkg.swupdate.delta,$(DEB_BUILD_PROFILES)))
> + 	echo CONFIG_DELTA=y >> configs/debian_defconfig
> + endif
> + ifneq (,$(findstring $(DEB_HOST_ARCH),amd64 i386 arm64 armhf riscv64 ia64))
> +-- 
> +2.43.0
> +
> diff --git a/recipes-core/swupdate/files/2023.12/0002-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch b/recipes-core/swupdate/files/2023.12/0002-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch
> new file mode 100644
> index 0000000..5f31827
> --- /dev/null
> +++ b/recipes-core/swupdate/files/2023.12/0002-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch
> @@ -0,0 +1,24 @@
> +From 2b1f4d9344f4855cd646f87df5fba57f52cf6535 Mon Sep 17 00:00:00 2001
> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +Date: Thu, 16 Nov 2023 16:40:19 +0100
> +Subject: [PATCH 2/2] d/swupdate-www.install: Fix path for debian-bullseye
> +
> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +---
> + debian/swupdate-www.install | 2 +-
> + 1 file changed, 1 insertion(+), 1 deletion(-)
> +
> +diff --git a/debian/swupdate-www.install b/debian/swupdate-www.install
> +index 7e3d95c6..9c6113cc 100644
> +--- a/debian/swupdate-www.install
> ++++ b/debian/swupdate-www.install
> +@@ -1,5 +1,5 @@
> + web-app/css          /usr/share/swupdate/www
> + web-app/images       /usr/share/swupdate/www
> +-index.html           /usr/share/swupdate/www
> ++web-app/index.html   /usr/share/swupdate/www
> + web-app/js           /usr/share/swupdate/www
> + web-app/node_modules /usr/share/swupdate/www
> +-- 
> +2.43.0
> +
> diff --git a/recipes-core/swupdate/swupdate_2023.12.bb b/recipes-core/swupdate/swupdate_2023.12.bb
> new file mode 100644
> index 0000000..e4a3d6c
> --- /dev/null
> +++ b/recipes-core/swupdate/swupdate_2023.12.bb
> @@ -0,0 +1,53 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2023

...-2024

fixing up while merging

> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +
> +inherit dpkg
> +
> +require swupdate.inc
> +
> +DEPENDS += "libebgenv-dev"
> +DEPENDS += "libubootenv-dev"
> +
> +DEB_BUILD_PROFILES += "nodoc"
> +DEB_BUILD_OPTIONS += "nodoc"
> +
> +FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files/${PV}:"
> +
> +SRC_URI = "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master;destsuffix=${P}"
> +
> +SRCREV = "6ccd44a8539ebb880bf0dac408d5db5de7e2de99"
> +
> +# patches
> +SRC_URI += "file://0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch"
> +SRC_URI += " file://0002-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch"
              ^^^

extra space - fixing up

> +
> +# suricatta wfx requires suricatta lua and the dependency
> +# is not set automatically
> +DEB_BUILD_PROFILES += "pkg.swupdate.suricattalua"
> +# add suricatta wfx
> +DEB_BUILD_PROFILES += "pkg.swupdate.suricattawfx"
> +
> +# Disable cross for arm and arm64 on bullseye
> +# with cross compile we have a unsat-dependency to dh-nodejs on arm/arm64
> +ISAR_CROSS_COMPILE:bullseye = "0"
> +
> +# add cross build and deactivate testing for arm based builds
> +DEB_BUILD_PROFILES += "cross nocheck"
> +
> +# use backport build profile for bullseye
> +DEB_BUILD_PROFILES += "pkg.swupdate.bpo"
> +
> +CHANGELOG_V ?= "${PV}+cip-${SRCREV}"
> +
> +do_prepare_build() {
> +    deb_add_changelog
> +    cd ${WORKDIR}
> +    tar cJf ${PN}_${PV}+cip.orig.tar.xz --exclude=.git --exclude=debian ${P}
> +}

Jan

-- 
Siemens AG, Technology
Linux Expert Center


