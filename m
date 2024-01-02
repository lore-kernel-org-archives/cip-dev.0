Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5794C46CD2
	for <webhook@archiver.kernel.org>; Tue,  2 Jan 2024 16:46:38 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.45])
 by mx.groups.io with SMTP id smtpd.web10.33292.1704213996249827058
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Jan 2024 08:46:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=yr6uAE4H;
 spf=pass (domain: siemens.com, ip: 40.107.22.45, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T105PZxTg31E9PkG+zlTG0eJcMvbkNJ0lQcJiarK7K41YKs8lwW4S4rRvp3rjqFto8DnkgJfRo+YH2wAgWcfFqG1GYIXhf16yajVPYCg1IInxaXe2+ykIlH3c8T+xvI1ongjT8EuzlPG1GJ93RUA/nf2MGKQy7/vPCD0zmARec6rnOHoReAeqjozTz+R/4eVkd8jlX9oTjjR5lZMxV1oaHMPSvIwApLSPbmkd+Kn6yFCBLgenqQbHj7+koZCgN2m207Z6kA63HrEEla6bNsIEJ+69pmXYWWWQPbGS43Qn9uLXRj4Z04FI8txtmBvREC+vvXsBx+lFT1GqKoqzqa83g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9loYIM0pU9WzevrwvPz5ST/TcEC4YcZbDYNUpIh4ams=;
 b=k3nrHSv3VEv+xLXejag/xPT67I1iuWQGHcvYfGGlEwo7cPsF8xV5KUuFJb9HJx857OUL7l7bSBCOr31dguJ5JRNQkgltrl13PYJjQ11GIoQSD2f/wBOHUAhgtxRGi8ujrzCG8QBWnL7IS+mJwFB/Hqmf/dj8lNbWQ7Th/vfv2NLQmFGWZ8ISTPthG9Ovq7Nv9n6Pyl3DgvjZHwUMrIU36L1aWO2H9Y1dgcVBKpX0ntDR06TAkNE9Vmh+BDZFjQ/bsfGJJ7aIEytqxgW2JIb8NYqmaiIAYDDE2aq0t9WTeCUOz4YH1xB0MWcj1P3qGQya2AMICT0Cf9PXcP5spWKcMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9loYIM0pU9WzevrwvPz5ST/TcEC4YcZbDYNUpIh4ams=;
 b=yr6uAE4HRTutKbFULHJYmD01izw+XFvKBv/dMAipbOqp4RJGCqxudMcEehT/F6PKa85F/lkRTYidm9YB2GWuAWlWJCGHcqbh58BIS00VWdqbSPsxSfqNwe4tMcs4cYqtROGKq/vkeo8JXp239x2EHoXhoNRAAv6nH/i5QJqcY615YkF4mcoiLbeZQRywAUr5QNMhiRItZgWd+W6nRFf4wOMayAkRmdxxRkWt58WL2BJJ4/CWA+nAtrRVyvJm4b1JLBouTqPhXcReWxHIZvIFGWv2ISPWwG+DDosu2MtuVwLXiJIT8KTiRJs3zczJ+nIWbDD/szcoEBNuTr4/w/VNWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB8196.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 16:46:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 16:46:32 +0000
Message-ID: <87657383-8ab3-46c1-98c4-9a7565ed39ca@siemens.com>
Date: Tue, 2 Jan 2024 17:46:30 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] scripts: Add automated recipe updates for
 linux-cip
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB8196:EE_
X-MS-Office365-Filtering-Correlation-Id: df945d30-bf64-40e5-8af0-08dc0bb25fec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tlQpx43a7Rj9rTwQrclHHIzJ2TCf/80w7Lzm2VJV8cCf+c3VbvAd1hy27v4SXE38CLljpRd/I3dFRGNu+NCwMCng+ynqKFpSFqnh71uiUoGN+fC768azks9ohX76hsCAiXv5AaSP8OSNEnxHclgG5rhp5CJXHq5Kpw3F0hERylYtgd9tM9B3cfVQ1rUhD1gtetMhR2M46eHoBEaAVN4ub4gSXPZKvIkVmu33gR+P0bZ1c1crTDDK98dY+LdbUKL2/uUPySG9E6ppYSIk9JcgZO8qnnMKko5dWqY7DNB24t57FWl889wsmLGXAW4gSDOscw3wtCDqv5moNonOC1ij9KY0DPDjyX6H1yLYclKC9pYQ7zfTYi2/D3tf4mNZqF4GwZp+psKPrEAWXc8DwJd1mXKOQtfWpXrMFExBrrLiWOxH7oCUxEYwAalQebC/uHwaQU7b4S1g5Ah9RoWXX22K2VOJ5DW2omuukaXSRluDoUNYXQgLJ43y9GYbhSHI1Lee9qONjvEbotNa/2Dpbs+0aGJZLs5yEc6g6XJIWK8aqkzN4YyUU7HSXJfKnnm0H6sJYmM1dXfPYXSS8wyLzlAStboTevIvC7yozlyEbid09VbDPEYNg8edbmlCRuxL6xU1+P+GXbZ5b5YX2HBF2pePDA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(38100700002)(86362001)(82960400001)(41300700001)(44832011)(83380400001)(36756003)(478600001)(966005)(5660300002)(15650500001)(316002)(66476007)(6916009)(66556008)(2616005)(66946007)(26005)(8936002)(6486002)(8676002)(31686004)(31696002)(2906002)(6512007)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dXpiYU5uaUVkSTVmaGpSQmRWbXlKWkpIZWVyQmxsU2xNMmFwcjNMN3JQdWxl?=
 =?utf-8?B?U04zK3lpTHFkbW93T1d0MjJJUHdiaGM3bmxuM2x6STY3NzNyc094RlRrT0xM?=
 =?utf-8?B?eVc3TitjaUlnU0lPSlZSWDhyR29aSE9FZExwdzlqVjZRSlFLcld2RytMcDNq?=
 =?utf-8?B?UWZVNytkd3JFYTAvUHJBODVsd0RkRmlCT2F4VHMva0dKb2JTUHF1U0ptZXlt?=
 =?utf-8?B?SG5YN1laWFhHKzlVa0lDSm9OTXZWR0pMTWxOQmZxUzNPMkdxYlhsQWVBYzYx?=
 =?utf-8?B?dW00UExLcFVNSy84bUpIWmhyNXhHWW11NE84UUpOakdFTk5KS2xKa3JKK1Za?=
 =?utf-8?B?OWRwdDVuNkNYQS8vVFFzcjI3K0NSVFpHZmxtQlRtNUlPMi83RXQvOXZrdGN4?=
 =?utf-8?B?Sk81emVuSVZEanpvNzhvWFVKaGc0Z2xrbjhaaWtnek1saEtoMjBObG55QUtS?=
 =?utf-8?B?bWhpVlFyWUJpWFpPQkRCNzQ0ZjFMcnlYVkUwODZYa1FBY2EyeWtGSmduZGhE?=
 =?utf-8?B?Z0FHNlViaXFETGZlZndxbTI0L1ZQMUtDWUZEMlZEV2Nqd0tEQWUwMXNUZ1U3?=
 =?utf-8?B?M1JERzNnZWlYQkJab0ZsTEN4NWFnUmh1QUVkYkhVMlJuN3hyNWZKUnhjdjNT?=
 =?utf-8?B?Ym9zZTFEU1NZTWFUWEg2eDJ1a1NPRmY0eFVUbGhycDdZSWxySXgvSGRoNVVN?=
 =?utf-8?B?RGRFbWZqdFk3emRNV3prdnJ1VW9GRU55UjUvSlBYQmIyWFcxZFZBWTRZLzFI?=
 =?utf-8?B?N3FhZERjTC9hN2hka0lWTWh1ZE92OUpkK3ZkNVRiQlpuSlNNRVFDd1lKbUJZ?=
 =?utf-8?B?cnNjT1kvVmRKakhGWW1DeXZiQ083d2crSVJtN1FIbnpXcDI3ckh0dzRqOURF?=
 =?utf-8?B?U2hFVzYrdjUyUGV5U2hKZ0MwY0FWT3Fmd2cwbGxhVEZKNUJTR1p5cFhqc25i?=
 =?utf-8?B?T3VXeDAvVUFBQnU3TVdJMWxDQjBaMVFVZzZJd1k4aHRLa3RWUGhQaXNZcHdj?=
 =?utf-8?B?OTRuSisrTWpZaWdPdFNmUDdqWjVNRjN6bXpNMVJvaEhENjlLRTI0UjZvZ1hL?=
 =?utf-8?B?OVlTWHN0U2YwMVU2aTVmMTh4ditwaXFYZkxHdzdFZXpEVDF1YlNueGFkMDNC?=
 =?utf-8?B?VWFDWmhmQ0JUUjdiQTJRT1o0M0htUVU3U3dCRWI3YTJ0ZkJjS1ZYaExwSkU4?=
 =?utf-8?B?WEVtY2orNjZsRnhXazZ6Yy9vWlFhcWdaZE51bDhSS3lDUHVwL3hERENnWHhC?=
 =?utf-8?B?UzRpcHB6N1NUSDQrSFlhVkRhaVRBaXpPVmgrNE96L0JDekFQMUFKbjF6dDV1?=
 =?utf-8?B?c05CMUpUK3M2VWllMzlreWhCanBiN1RiS3lGbEMyVHExTGkxbStMMlI5Y3dW?=
 =?utf-8?B?dEF1OGF5ai9SRUNJR29QSFVBR054cjFwMENBTHRTZ0hCdFFxdGZTNURmWTdP?=
 =?utf-8?B?RVREbHNha1o2WXVqY2ViSGM1YlVrbkE2YU56aFVyUGFaUENZK1l6Mk0yY29B?=
 =?utf-8?B?QnNtQWpmVlRJQ0hJbksxR1JvZWV0REI2bkxUVnE3emh2OTJickt4V0x1R21w?=
 =?utf-8?B?dTA3YUpTL1h6RzUwSVQvLzJ4Q05iVXVsc1BweVBrdGFJeTBzZkh5S0JuVEwz?=
 =?utf-8?B?YjU4SjJCcXl1SHpYR2NLNDVhajJ2UkE0NG5nd3pZYUwzMW1TYmdaOXovZ25o?=
 =?utf-8?B?alczK240MXM0T2RMQTJhM2cvbHhRbmZSKzJIU1Z2WmFEUERZZkJRRFkrR1oz?=
 =?utf-8?B?enVzRk5URWNmY1FpdlU2TVNnUEdabVRwWEFjTEJCYVMxVGtXL1ZSZWhjakpD?=
 =?utf-8?B?NzZzZDhnRHcxQ0txbnBnUW9WOFdQdWZ5N0dyVDFlWGUzb1JiUERBTWp3S1Qz?=
 =?utf-8?B?WjF1Z0JXaFRPVmM4YXdkbTJJSTBONmZlbExJcnZ0VzU2VVQrc3R6NFlqNnlK?=
 =?utf-8?B?amF6eE5mZmExK1gwZ3IrdGgrY0tlcmd6L3JCbG0zL0NzdTNMa1RVdEFUaGJE?=
 =?utf-8?B?RnZuaDNTR292cEVnZ2JGOVBUVGxhZjNPVFdZKzVEbkk4SVE3L0IxejEzdHBu?=
 =?utf-8?B?clhvdElkYWZFTytJcEx3b2lZS016Y0wrWTR3MEwybys5R1dTcitBNWViRkZF?=
 =?utf-8?B?SDdoeXdHTEl3TGt6Yk8yNDBsanArc0ZFMkxTZVVaZGhHdStSdVdsTkFyK2ZV?=
 =?utf-8?B?WGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df945d30-bf64-40e5-8af0-08dc0bb25fec
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 16:46:32.2094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VyKrXKbc1uvGoN9k4Ia3EjNMFQT5c2uqtcgH7NBHclKOx6Qr0y9r2YY9B/NrkDqeIpm9D6vxHHP5pUMHv7gwxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8196
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Jan 2024 16:46:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14233

From: Jan Kiszka <jan.kiszka@siemens.com>

Should make life of contributors easier. Just make sure you have run

gpg2 --locate-keys autosigner@kernel.org

before calling this the first time.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/update-linux-cip.sh | 39 +++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100755 scripts/update-linux-cip.sh

diff --git a/scripts/update-linux-cip.sh b/scripts/update-linux-cip.sh
new file mode 100755
index 00000000..e4e170f4
--- /dev/null
+++ b/scripts/update-linux-cip.sh
@@ -0,0 +1,39 @@
+#!/bin/sh
+REPO_ROOT=$(git rev-parse --show-toplevel)
+pushd ${REPO_ROOT}/recipes-kernel/linux >/dev/null
+
+for MAJOR_VERSION in 4.4 4.19 5.10 6.1; do
+	rm -f sha256sums.asc
+	wget -q https://cdn.kernel.org/pub/linux/kernel/projects/cip/${MAJOR_VERSION}/sha256sums.asc
+	if ! gpg2 --verify sha256sums.asc 2>/dev/null; then
+		echo "sha256sums.asc for ${MAJOR_VERSION} invalid!"
+		exit 1
+	fi
+
+	LAST_ENTRY=$(grep "cip[0-9]\+\.tar\.xz" sha256sums.asc | sort -t p -k 3n | tail -1)
+	VERSION=${LAST_ENTRY/*linux-cip-/}
+	VERSION=${VERSION/.tar.xz/}
+	RECIPE_FILE=linux-cip_${VERSION}.bb
+	if [ ! -f ${RECIPE_FILE} ]; then
+		echo "Updating recipe to ${VERSION}"
+		git mv linux-cip_${MAJOR_VERSION}*.bb ${RECIPE_FILE}
+		SHASUM=${LAST_ENTRY/ */}
+		sed -i 's/\(SRC_URI\[sha256sum\] = "\).*/\1'${SHASUM}'"'/ ${RECIPE_FILE}
+		git add ${RECIPE_FILE}
+	fi
+
+	LAST_ENTRY=$(grep "rt[0-9]\+\.tar\.xz" sha256sums.asc | sort -t p -k 3n | tail -1)
+	VERSION=${LAST_ENTRY/*linux-cip-/}
+	VERSION=${VERSION/.tar.xz/}
+	RECIPE_FILE=linux-cip-rt_${VERSION}.bb
+	if [ ! -f ${RECIPE_FILE} ]; then
+		echo "Updating recipe to ${VERSION}"
+		git mv linux-cip-rt_${MAJOR_VERSION}*.bb ${RECIPE_FILE}
+		SHASUM=${LAST_ENTRY/ */}
+		sed -i 's/\(SRC_URI\[sha256sum\] = "\).*/\1'${SHASUM}'"'/ ${RECIPE_FILE}
+		git add ${RECIPE_FILE}
+	fi
+done
+
+rm -f sha256sums.asc
+popd >/dev/null
-- 
2.35.3

