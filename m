Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62BAC47DB3
	for <webhook@archiver.kernel.org>; Thu, 18 Jan 2024 18:20:41 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.89])
 by mx.groups.io with SMTP id smtpd.web11.397.1705602033808426081
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Jan 2024 10:20:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=jZRg2t5X;
 spf=pass (domain: siemens.com, ip: 40.107.8.89, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIV3TFOwF1TjViQBJWhx+It9pqMRF1PXy5n3BvVhWMcM33VOFgNVk6Fa2UYMvc1aIPTQqCz9IsMRY0QsjwYbJy5xbUbeYbrcpAPSMAjxhgBwiH5BCZHJQZ+uSi64WEhZ5c56pQY3lxP/5o7vTHSzz14HQg9ZQ5eArHJAssZMd2MQyaKITkGyOURKXrEnfVrwf1zs5aHGoOO3OXmHjLZnDzLsdFzgOTyCuF67j3Wys0yc624Y2KUaqHigZzJhNrvO/Xw9PopHztyG/7o2BpaeUdj6pCYoWKE0kL7tektQGczAgigsKcfSZ6QrKc4CunjwjiRMqlEN9G85hNq2LAIyTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8j23grQw7sKGyj41WayYJuV8FjQeDOPc13cvtjq4jpQ=;
 b=UqA/47rsPaDSe8NfagcMKkc6SG6JKGlVMABfTdYHrqx4JkLOWjmUhqTTsaizIpeHA1Wd+A08GnVLPz4H0eQ7Ds1nVAUkA3nXBVNXgA1aRA9KXtyzNoQNKHwmw1YoUIdRCwAgt3yg6OCI4xN3aATItL/dZDNGw9EmcV2q/qaohwAZZePbcVAqCIXdZVuRFm3p+lPcKBmH93AoLmltPiDLLhJcs3GvDWFqCPA1Av9UcIqgC4UnHUCr5EiIQxoyrAYrndJ+JPag+5KyAJJHr/ATWfUhmZ/d0jsU1uAfFGFRCBk/kACJE7OcPDjUovlt+pKmQ/D8wajqu4036pkIM4zmhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8j23grQw7sKGyj41WayYJuV8FjQeDOPc13cvtjq4jpQ=;
 b=jZRg2t5XsxLhJm3o+/Q/vaD50GrLRnMT/AEAGRQmpAWXnAUTHRxA9WCO7rj0m/TaStHtUcoIl2DC0QCq7p0DBqizd3EF52y/kmte2BIpj04GChV5SPMuwEnjnkkk1pD99/V0+nlIg9FOXWMO5YTT6UvEx/yJ6of1O5624FWxIju2cPqAjj24UlOEemP7Tm547okmqKzlKXG25xbmw94oIGIiJO9TNr/2POBAhpxVDec6WTn/BKubT7XpGQz3eCivOe3JMuauoHwuXE8+CfCZr+02P4Z7Kyr+2pXFQxC1x7O/dmu9tRiwFGp4dbfVH9RzzP2+ZpPc/jhe476UU5zp3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6227.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ee::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 18:20:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 18:20:28 +0000
Message-ID: <7f6da87f-56ed-468b-a935-0d62c4b19502@siemens.com>
Date: Thu, 18 Jan 2024 19:20:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v2 1/3] scripts/run-cve-checks.sh: Add script to
 generate CVE report
Content-Language: en-US
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240118175942.1052089-1-Sai.Sathujoda@toshiba-tsip.com>
 <20240118175942.1052089-2-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240118175942.1052089-2-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6227:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a83cf5a-a79e-4996-f8a2-08dc185225e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	j9+NenLzWABTLQRUBw+RESOu3teLoNfwpXOOW3XjeiZINB8k7E3BoHneib0z7F6eK5xHWy9GvqjRFyqC4oZVmPFATHMJZTlmFHWHk5W6hzzwJM4RfejvqoL5nUWZu/k+U3yUgaFJ8xrczS7O3MwKF5LEmHcIfFfvZU1PgqwsNnVCKvvPW7i35GekOC545qu0WAI5NGWmGQzZ+I6Ttk6pn02ICS4HR2nKQ/cRpHoAsmsqJNkF34lzCKq8aqSRFPauxEW+q4HBBwg2MJ2Qu/nL545YlneNY78ypbbR8MvASeci+J+iLkqpUeB3Hg3aVroXZOZ00hZDuMerq6Qu2SRF3eYGxeDXLwQvj6+BYyxKMvofMGxCrSSf+wGnsbF7CNhovlQFZ1bQ1iOVv2ApsLJGl+KVSDUHkfgytm1JJMdhXr0ttJ7lYB7OcjP6mIexz4yaGkct+ThFkL3h3kRfRQKebV9hVNKA1Zby7apmPj+xwKs51OHF8K+mwpENu/++iCxPW9Yjt6Hi76gdDAr956Htxm/rmfBPYlIW6vl+poTHGpCUtt3rkznKmuvUxOBppTAf5HWfJzdPcYlJQJO8hsNLu+urogC7rrtmdKqLbnzBGIbfgwUFFVpFBmSfmaYa6YjSbUoEia6spPQ5piZYdfOheyE9DCHUlNfHkzu58Zp20gN/wHk2ry24XXz36Ll4R7IB
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(376002)(366004)(230922051799003)(230273577357003)(230173577357003)(64100799003)(186009)(451199024)(1800799012)(83380400001)(26005)(6512007)(53546011)(6506007)(2616005)(38100700002)(44832011)(4326008)(5660300002)(8676002)(8936002)(6486002)(41300700001)(2906002)(478600001)(966005)(66476007)(66556008)(66946007)(316002)(86362001)(36756003)(31696002)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZTJGa0YzYnNCcUpKSzEvM2YvSUlLd0hKaCtTS0JCS3hObUpJck5YeTVteXJi?=
 =?utf-8?B?UjJTYzV2eVd0ZmN3L2pUVmVMMjcydW1lbkwrcDhGTENhMFM0bFFiTGE2KzR1?=
 =?utf-8?B?Wmc1SktLNzd4ako5WVg0ZTFtdXA4RjRYOGRIWGJ6eEFMUXFPaW14bnF2ZWVq?=
 =?utf-8?B?QS85UTVQRG5Sc1JPNDc5ZE5rVCtsU2FxMTYwNXptL3MzbzZYbUR4K2Z3YXdy?=
 =?utf-8?B?QUU3WGhKQjA1T2MwcDIrdUNGcFF4Ym5kVXcrc21IMWZHYkhRSmNOV2oxNzFO?=
 =?utf-8?B?WWN3MWFueTFjVUVNSmhsTW5MbWhwdDZjNkE5TnlNcmxBUkJuUmdZUzk2SEh6?=
 =?utf-8?B?ekFyVS9GS3pWUWNEbjZ2SkcwdFJvRnM0ZkN1QTZSUXpGZFMvSThDUnNDeEhw?=
 =?utf-8?B?V0JpYkxZNy94dnhVOW5yWGNSNzlZandzVmJkQlBPZE12Z2RZeHQxV1NkclEw?=
 =?utf-8?B?bCtFTnBHUzllZXFCL05TVEs2NnE1SEE4VDl2ck1hRXZabkVnNXVtR3lCVEFv?=
 =?utf-8?B?b3dUT3JpbndmZWh4aWI3MTVndUg2Vm42b2lYSmVldzVTRk1DbDYvYTROVUUx?=
 =?utf-8?B?RTRGMDlWNll5Y3Q4MjN3K3pkT3RJK2JVRG9MZElZMmNwaEJUWXFqeXpMQnFu?=
 =?utf-8?B?elVpV2grdlFuemZvUS9vdEV0RVRERE5HUWVra0dURVpkUGliTUhOZjR3UjRq?=
 =?utf-8?B?YmV1UFV0VXRNbWlGSXZwblY0aE1NalgrL0xOZzBSYnFKb3hKdm9Fcy9KYk8y?=
 =?utf-8?B?NnhSMGZhUDc0cW9aM2ZtaHVENE1nRmdRaW5YYW1oL2Rnb3VXcEo0TjFzczNs?=
 =?utf-8?B?UENKY1M2bGF0azU3TnRlcjN2QnIrMTZWS0d0OG5TbWwwQ0psY24wV0JrQUpR?=
 =?utf-8?B?WTJUMjQySks2RGJ2MERQRWJPMWVUUytrYysvVGwvUlVrd3hsbDhweTR0MGRJ?=
 =?utf-8?B?RjVUQXI0MGhwaWhRUmI2STdTWnlyaVFzNzQ0YWlnZlJQWUdybjluUkdiTzVE?=
 =?utf-8?B?VFdub0VrZ2NOc1k0NENuaTFKbjY2TmZyWDlCVlFkVVgrcmxpcklBL2YyZFFF?=
 =?utf-8?B?TzN3NUlCbitydmtiN082N0Y4dFQrY01qeUllbktXd05zYWhIYnArWkFpdlk0?=
 =?utf-8?B?aXlsTjNaMnpPVE9odkVuT1NsYXJvT2g5SXZ5QnpPM2QrMnVpd0h1b3N2N25i?=
 =?utf-8?B?cE9ObzZJdk5pb0t5R2Roa05iNFVaTlhCM1BBOHJBUnluVVpId2o1UHB5eVZt?=
 =?utf-8?B?T3BrSWJRSUM5NWZxYjdUTElaTUxuWldaYUVtL2dCb25NNlBoMUhUV2ZtbGFt?=
 =?utf-8?B?L0l5RWl5eVUxc3VTSVlPR1F2MklFRTdTVEFVcnh4UFFUTDY0ZWM5UXU4cEhq?=
 =?utf-8?B?V3JOVUR6cVl4eXV2bkFNQlV6NmZCWnRXeVZhTEU5RXFuTVQrcTdENjRnaGJi?=
 =?utf-8?B?MGsvRzdlemx0MkZla1ZENk9uamllejlqdWJXUW5ZVFVqbm5HZXd1Qm9PbFNH?=
 =?utf-8?B?MjJsdkU0R2hJTTZaYUl3aGw2K3Vxc0xHbDhQUEhxQWhwMDRGNHhIbElpVnZ3?=
 =?utf-8?B?WGtpcDVqTUh0NGFOTDBkY0tjUEdDc0krUWEwd256MmtkcEdxTm9OMTlGblBW?=
 =?utf-8?B?eEFQVGxjSE5LY29oQ21EUDErZldJY3dvaThzd3h3OFNxOFBycU5VdUFNcVVU?=
 =?utf-8?B?T24rQWpaczRRVzhMTWwzTEh2ZDBFbGZPTnpSODNvVFByTjBjVGhucmttZURJ?=
 =?utf-8?B?cS9JdWpMNGNBQjEwM2NHd0hBRjhLME5ySFFwUjZZK0FpbHljemRTbEZJbVdq?=
 =?utf-8?B?YXhEdFdiRTJpQ3IrLzUyVnk2L0Mra3hSeC8vVFRKTkg4c3daZ0cvWCtWNVJ3?=
 =?utf-8?B?Y3dnY01OT3Y4REcxTGlaM2RaZzJKaEdFZ3QxMWo1SmxJRTNJNjZIbDlDVlM1?=
 =?utf-8?B?VmJZaW1PYUVZNkJXRDkwelpoaEJjdUtKaEZqckVkbjZBY0g1Unpqd1ZPNDlJ?=
 =?utf-8?B?NGEwTjBtN1JzV3ZIZk9SM3plRTVFTDAyRDJMT2wrZE8wOVBPMDRZcWV0K3d4?=
 =?utf-8?B?SXBCOEJ4ZVAySVBoSTZDdjhvNDRJM2NHS0lWbXgvZ0o0bVV5ZVdEY1VEK1Va?=
 =?utf-8?B?N3gyVy9nUG4xdkh1cUN2eEd6U2tTQ1NKSCtqUkFWMnJvVlhjSitBRU5RUHZ6?=
 =?utf-8?B?OVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a83cf5a-a79e-4996-f8a2-08dc185225e9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 18:20:28.3681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +o5Seoc7WNlHQd/4LI+9eBOE3QT2I0RdSAq6Bd4J30iobf/o/vah0tiJbNiMydOx7AN/iX98q+wK5zjLdZ1AwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6227
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jan 2024 18:20:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14405

On 18.01.24 18:59, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
> 
> This script will extract latest dpkg-status files for all the deployed
> targets and generate their CVE reports using the cve_checker.py script in
> [1] and these report shall be uploaded back to cve-reports sub-directory
> under cip-project.org in the s3 bucket.
> 
> [1] https://gitlab.com/cip-playground/debian-cve-checker
> 
> Signed-off-by: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
> ---
>  scripts/run-cve-checks.sh | 40 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100755 scripts/run-cve-checks.sh
> 
> diff --git a/scripts/run-cve-checks.sh b/scripts/run-cve-checks.sh
> new file mode 100755
> index 0000000..15a2bd8
> --- /dev/null
> +++ b/scripts/run-cve-checks.sh
> @@ -0,0 +1,40 @@
> +#!/bin/sh
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Toshiba Corp., 2023
> +#
> +# Authors:
> +#  Daniel Sangorrin <daniel.sangorrin@...>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +# This script is used in .gitlab-ci.yml to create
> +# CVE reports in CSV format for each deployed build target.
> +# It uses the dpkg status files generated during the
> +# build stages and saved as gitlab-ci artifacts.
> +
> +set -e
> +
> +# Install AWS CLI
> +if ! which aws 2>&1 >/dev/null; then

In scripts/run-cve-checks.sh line 21:
if ! which aws 2>&1 >/dev/null; then
               ^--^ SC2069 (warning): To redirect stdout+stderr, 2>&1 must be last (or use '{ cmd > file; } 2>&1' to clarify).

BTW, some alternative:

command -v aws >/dev/null

> +	echo "Installing awscli..."
> +	apt update
> +	apt install -y python3-wheel
> +	apt install -y awscli
> +fi
> +
> +# Retrieve the latest dpkg status files from AWS
> +aws s3 cp --no-progress --recursive s3://download.cip-project.org/cip-core/cve-checks/dpkg-status/ ./
> +
> +# Create new CVE reports
> +mkdir cve-reports
> +for i in *.dpkg_status; do
> +	echo "Checking $i"
> +	filename=${i%.dpkg_status}
> +	cve_checker.py --status $i --output ./cve-reports/$filename.csv

In scripts/run-cve-checks.sh line 36:
        cve_checker.py --status $i --output ./cve-reports/$filename.csv
                                ^-- SC2086 (info): Double quote to prevent globbing and word splitting.
                                                          ^-------^ SC2086 (info): Double quote to prevent globbing and word splitting.


Granted, this is pointless here as we break up *.dpkg_status into i 
above. But it would silence shellcheck cheaply.

Another nitpick: "i" is not the best name for this local var. Even "f" 
like "file" would be better than "i" like "integer". ;)

And then "filename" should likely be "basename"

> +done
> +
> +# Synchronize the CVE reports to AWS (it will delete old reports)
> +aws s3 sync --no-progress --delete --acl public-read cve-reports s3://download.cip-project.org/cip-core/cve-checks/cve-reports

I'm fixing these up while merging, no need for v2.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


