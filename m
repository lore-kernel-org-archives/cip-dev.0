Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40E5C3271E
	for <webhook@archiver.kernel.org>; Fri,  5 Jul 2024 15:36:08 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.50])
 by mx.groups.io with SMTP id smtpd.web11.19936.1720193766690245461
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Jul 2024 08:36:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=rkTIZDM0;
 spf=pass (domain: siemens.com, ip: 40.107.249.50, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WE3yeZzTKyeDm/HfrG5b5UAuElbWkg5AFvLAXtMGIVoq10PlPASnuQazDYHT5PPtN0p30YQpfS+ntAOxiBiWhPgKlR9vT5lkzg4DmlQ04JddReKdQ2sXGRc10MPpRZp87pFq4kKxv+3cPkU3t3soYh1Dmys5xrz2CD1WXPdiIzSx3hEY/cEooCSB5CLwCmvekxUVZZdr5+vWoSF0orRx0kUaAQf47AGO0RVj5jSxbg+vpSGpLnmQvWm8g7p3Vy7oNTIrV4fYZs48vCMskc7njFwPZoqOfYW5rX7Yr3ZuQUg/ZHGfTzOcXdyMfnkDxiAR2vLujxGMMnrCY5XeX4SgoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjY8EFEgAM08er4He/3GiBVOpxVvTCn2zQ0oQ8lM7rQ=;
 b=YQAymduzGsRn6DNg0bw3BMyKvIxkkGPnfJIwpKG/r4RlyG9ebGUZUVN5Q802gPxzK6zFXHm4aL1dqzRxsKRm5ReBueb4+5tx06ZJxDWmeGOq7I+14nI5cHemBe09QFtDj6qr6ijLlQWDM8pfJPJ2zmfivGFLahyHGrfC23ND2KyseQ98yE/iGeWcmUPgqFIDKRjntS19XkVKtceKSfU/T8l6RliiwG5vm64Auc70Bezki8zGrlnzhkVsSRRg6EOSp2tRM1asyeWQJSoBAac+Og9q4+InPs6haAZhuGOKGk+7DCPgKNoA0MPUprt+POU4jxG1jPgeJr4cMMau/tbX6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjY8EFEgAM08er4He/3GiBVOpxVvTCn2zQ0oQ8lM7rQ=;
 b=rkTIZDM0V5W3s1rkudZkQHZOIm6KvIapPAnzMfRzZyjTLSzga+rV8/tL8OnaCYQ1d1DamDGolXj+c1d2xQALwhGGG//pxnf49n8kRAMEEVQaqxAIGyOASQLuTOn1M0k81HLdfE6srAw/Xl2I3Er3A5QS1CWhriE8xGoJcNWvG4MpkSe4U2h6n84Z2dP+FukzhmPM2ocdKl8qYeqpocM77U2gRxXKzTCzLRGFxV+AN8uzCFDqoA7zL315BmG1yug/Hpn9ih5zUfq1S0dVhAjr8ckKH49/kZL60LpEosNQDkxPRgHGHH6CiV0pb1dMJa87UllGWnuK8uRC/70Oxchgsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7338.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:462::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 15:36:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 15:36:03 +0000
Message-ID: <0f90dc2b-227a-42fd-964e-4086d00e9694@siemens.com>
Date: Fri, 5 Jul 2024 17:36:01 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH 1/3] ci: submit_lava: Improve detection of
 failed jobs
Content-Language: en-US
Cc: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>,
 Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: a7720d44-260c-455b-b645-08dc9d082df9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UmNVdlBnalczODFZdEt3OG9uVEUwTmUybUllcHdMNEw2WTY0WWFKQjV1bHlM?=
 =?utf-8?B?dGVVcWNNdld3L3lZRFQ0a3lObGZ2bHg0UHIyMFRLbkc1bm5BTFNrRG9RbU9S?=
 =?utf-8?B?NTVPVC9XQi90OFhoTHprajhMbGN5SmRJQTRZdGRkRm13czVIaENHSG91d0hN?=
 =?utf-8?B?MXNqYmhZMWlqREVOWDFHTElod1VFS2tuanhET1AxaTc1aWFQSTQyVTF5YWZV?=
 =?utf-8?B?UE1jY0paNlZoc21vNWVYRWl0RUZlMUx4bS9abjVPZk5NN25tdkRSbW9XamN2?=
 =?utf-8?B?eEFxczEvNHpXeXNRbFE4dVRRMVhIdExEZXdjaGhWZ1p1RmFVQXVUWHV3Y2Er?=
 =?utf-8?B?aGtKWGtnL3VmQzdhelRQbjhEQTZoSU1TakJ6NXJ3aGc0WTJvWnBMUGp6Q1o3?=
 =?utf-8?B?TDh0N21KR01SSHBTZEJnRSsrangvckJxTHlFMGQ0WFhlbzlMdlE0dWduZHVP?=
 =?utf-8?B?UmYrNWd5b25nb1E5Z2N6aWdEeURDSVZZWVh0c2trdy9UdElZb3RaRXJNZlhG?=
 =?utf-8?B?NFU2ajAzOVF0L3grWU9vbTJ1NjFoTGx0aFBZUVl0ZGRNdlVTU2licnFGT2xN?=
 =?utf-8?B?UUE0MDlrb3kwYkE0M0pXZ3V1M2wzaEUxZFd6cmxHWGkzWm1PMUdiaDYvMkNr?=
 =?utf-8?B?bUZkbVBsK3RtQlRoWGQxUVcvNy9mVHc5QVRvT3ZuUDBJRW1meG5nYWtTQnZq?=
 =?utf-8?B?RldRMENNaWNRQUdYaXRoejJFSDhmREpWUUE0Q2M4OEJlTHlLWk9yNE1vd28y?=
 =?utf-8?B?ZEZMQ2F0RUVKWCt1ZEY0VkZYUWR1V3BzMm1kK2JUYkdTcENCMDFXNXY1R21L?=
 =?utf-8?B?b0pVV1BidEVQNHd4UXJJQVhnTFBLSm8xN3Z6YlZFOUNhdHg4QWpNVXFHYzMy?=
 =?utf-8?B?WkhoT3FBVlduS2Q3dDk2WW9hNjUzOHVHRnJqZjdwQWtiaTVNQ2ZKMDh2TmNq?=
 =?utf-8?B?RGtnMkJMaVFOZ1lMRzhaZzFWMm1vWHF6VXdsYStlNHNOVG05UkdXTitUWWxM?=
 =?utf-8?B?TDZWSmpKSjNwcWF2Sm83eFIvS1h4dy9rM2hzYXpEeU1BclladzFCMTFJTkFo?=
 =?utf-8?B?cndMQU5VWFVqTWxTVUdMc2J6ZUFyL0lINXM5TStQZExlRVY4aUxPWGRkY3Zu?=
 =?utf-8?B?UkhvUExTRGRUL2Fsc3hEWHNOOTA3WHkxU2hTMCtyUWpPaEhGTVZZaGJLb2Na?=
 =?utf-8?B?NTBqMkxsUFgvQ1pFbzNsbXh1bDVpTHJJTXZMTndjd3FkbGRCV3FMOXBKMGNa?=
 =?utf-8?B?ZzFXc216ZUEzL0xPbU5va0dha1hDamxHa0dyMDQrd3Y3UmhsK0cwd21QdDBN?=
 =?utf-8?B?K3hGb3BRUnJhQlE3b1pIUzloSGZYcUlUaWRnMzJYMXkzU0t0Zm12U3RGSFhR?=
 =?utf-8?B?T1BQZGJNQXVxa2JXeGhZQ1ZoR2Y4clNyT1hqSHY0N0I5VDkyaytRTkxZYnRi?=
 =?utf-8?B?TGFsaUhKYjhZWU81RzdRT05NTjlTS04vd1VmK3c3NWlySmxiNGpaendiM1Q0?=
 =?utf-8?B?UXIxQXRKVjRleDlkUmZSQTN3YjVKODNnbm9uQTJEZjVQRk1uWHUvVTcvZ2JG?=
 =?utf-8?B?RmFQcXYvV1hlSVRMNGhvd0VJaVdPSElobllsV1NqKzhjNGhKNVgydlJRQ1do?=
 =?utf-8?B?SW9JVis4MFJsRTkwQk50ZG9QUVVJTWFVQ3UyaUJYTnpVaCs5cGNoMjdzVGFi?=
 =?utf-8?B?bEV5SFEzcGFJTmVnNTFoc245bXROOFFDdCtxQkQvckc0Q25adlY2UHluQmhX?=
 =?utf-8?B?OGxSMU9URlNUVCtiVEJ2TGxpNERLQW5heE1DWUxkTzU3akVyeEl4U1FOR1Rr?=
 =?utf-8?B?UUJ0ZW1TQm4xMEhLbUR3UT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R2U4WnRDMDNTKzREV1pSZjQyV1BOMGxlMHRzNlQvR2ptOTlvUEkrSWl1a2FN?=
 =?utf-8?B?RDZDOUN2YzhzMjFVYVdLVDZ1c0FrUmpmSVI1dTNrUjE3WEJXNkEzT1REVWt5?=
 =?utf-8?B?RUI3NnUwVEJzM1BXMG1zWnhwNFZZa0l5SXQ5V3hRVmNYYk5oU3ZWZkc3WGNj?=
 =?utf-8?B?TG1oVWNiNDlGUElIK21hN3F2K0kxNVQ1SzgvMWhzTDUvNkNMejVNRlh2VDIz?=
 =?utf-8?B?amFHSFl2L0h4RlErSWJGNTZyUVQyeEhaU21vdDhjd0hXTVQvejVMVnAxVWx3?=
 =?utf-8?B?RU5qVnZEbzFpa3dBMTZBdUgyZGVBV0ZMQWd6cW5HdTNLQmxWamNIZlpvcU9h?=
 =?utf-8?B?b2FFRlpPREQzUHUrenNtRDlNTDUvaHI1d2k0blprc05kM1ZxU1UxbnFYbVNV?=
 =?utf-8?B?eVI1TC96b0ViYXBKN3NHQkFBYmswME9IdDNuRGlLUUJWcnJjRnJvdUpKcGRM?=
 =?utf-8?B?QjBSTTFFVzBoZ0Z4N1pkdTEvRVdTNThXM0d4TThuWjZPL0pQclZVMmluWGFZ?=
 =?utf-8?B?N2RuK0Foc25EUkVBNUNucG5DRjhUYmMrUEp1TnpLQ2FaWGZHSmpoV0Rib2g3?=
 =?utf-8?B?ME5MajdyL3JDNGpOSTJEU1pibkFvRE45V1dva3ExYWlQYTY1Q25OK1NjVkZp?=
 =?utf-8?B?U1Rib3dCNlpSS1lpSW5LNjFpbEVXUVRzTWE0alNtYlRLNXBwNDltSytZWXBx?=
 =?utf-8?B?Qk00TzExc3J3SEU0Ym8wbEIyUGtLbThsbGs4d21tY3FTUm9mUjA0dlBxWW5l?=
 =?utf-8?B?QjRyVCtwb3pKcE93M2k0a2JBMlkxbGhIdWJXK0ZWZ2tQYnN3WkN1MkZTS3Q0?=
 =?utf-8?B?OU5QSkZiSW02bVpPY1JEZGVsNWcxZFZxSmFTd1czRmdGeEFUTjRlQ09VY25O?=
 =?utf-8?B?WXVnZ1NtQjZISFcweE9LRm5uNDdCQXA0eUZzclRaZVRQNUhIRUlseG9qVUJw?=
 =?utf-8?B?akhrSGI0elBFRnZ4MEVDR0YrOFVTNzVZdVJ4Y0RMdGRjUGV3YkhNRVB3bjh3?=
 =?utf-8?B?WmRFQit4aHB2M2dKSGMzRkh5blJZcHByVkFQN1MxaDF1U2hzSVJSczUxWDE4?=
 =?utf-8?B?WVZHdDlHRG5tL0t3RTZFaG44dS9GVTZSd0pqZVcxeUV2QzBZRnM3NjlTajZY?=
 =?utf-8?B?R3RDL1hrYlJUSnBPU3J5UDM5RFlDVlEvK2UzbmNBWC8xNFcyOTRpeDZhUHpN?=
 =?utf-8?B?WGFFTDFna1c3ZlpRTWdHVDdWa3FCemduV1Y2WlJTT1BTZXlxaExTMHlabnN5?=
 =?utf-8?B?L3JkUjhESEpxVHE5b0ZWR2R3TSthdFhlWGFKWWVvYk42dm9ubDBocUVZMGxR?=
 =?utf-8?B?YTlaODBpMW54bXlSU2NtNnY4eVNSc0tla1kxd0tUcDYxSWxuUk5Gb243T1Vn?=
 =?utf-8?B?WHdENXIxZU5YTE9sUGlIMXFyeFVtYXEyMjRCYzZxNVBVN3JDUGhkM0xFRE9v?=
 =?utf-8?B?UjVBSVg0clN5NUdySDdtVXN2ZndQY0Z5MTJrdk1ralhtN3RhcEZnd1NTOFhP?=
 =?utf-8?B?SGJVUFVTWk5IUzhGNGk1QmZaVFBLZzBrdDN6U0ZucVV6eDEzcUtSMVRtdExZ?=
 =?utf-8?B?Q1o1M0V4NXVFdEd5eEg0K0VNdktkYXVCb1FjNG1NTEJiWmNveTFpMTFZaWw0?=
 =?utf-8?B?eE9qL3RrRytaeVo5UTFDbk1FbFZSYmo5V2NMU0lBUTU5Yy9SNy9hK2picXNj?=
 =?utf-8?B?UXpWSnhqZFhTb2o5K1B2cTdJbW9ud0d6MFBSQjhrMStMQUNnZGF0SWg4TTF1?=
 =?utf-8?B?aHNOTVAvR2p4cWIvMHlVL05IVFlRa2dvclEzM3ZiRUhDOWxOV3FQRVdNR1da?=
 =?utf-8?B?YlMrZENIdnJqNkRaUXEzUXVGREV4QnBwbmhaNi9vS0NOdlY3UFlrVjV1RW1Z?=
 =?utf-8?B?bHVqWTdwbHQrcjh1TmR2U1h4b3Jqb05tekl0UTJJdnhLOVdPdGJBUm9wN0pT?=
 =?utf-8?B?NmF4UndDTVg1WjVCKzREb3hnL0xtME5QREdmUDVFeGhoL2t4WmQ4S1JoU2VW?=
 =?utf-8?B?cnpOWDMwd1NBbXQ1c2xaZzAweEU0WVd6VXcvZS8vWVI0YVg0V3pwd0daMXEx?=
 =?utf-8?B?alV2Z1IyZVFGKzNQeTZyamNYWVQ5TitjTkZGNDlJOEZjR2JzaGdnNWFvMXgy?=
 =?utf-8?B?RlVGOU9qS1E3VFBUeklaellMZTkvZ0JIOUZSSmxPa25nR3NZOWZ5L1J3Rk9T?=
 =?utf-8?B?cVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7720d44-260c-455b-b645-08dc9d082df9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 15:36:03.7893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZpmD/xESPeqn0+3nmO91tQE9KezanGixIFkm6AlNsPsoHqeLd8wMlJs1jUjSMzG1szrsl9v1cGoTkAabwrCIjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7338
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jul 2024 15:36:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16419

From: Jan Kiszka <jan.kiszka@siemens.com>

Rather than counting errors and failures, only query for the failed
testcase "job". That avoids reporting failures when some job was
successfully retried, specifically download jobs.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/submit_lava.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
index 7f151697..b9015f3d 100755
--- a/scripts/submit_lava.sh
+++ b/scripts/submit_lava.sh
@@ -35,7 +35,7 @@ image_args[qemu-arm]="-cpu cortex-a15 -machine virt -device virtio-serial-device
 
 set_up (){
 	echo "Installing dependencies to run this script..."
-	sudo apt update && sudo apt install -y --no-install-recommends lavacli curl
+	sudo apt update && sudo apt install -y --no-install-recommends lavacli curl xmlstarlet
 	job_dir="$(mktemp -d)"
 }
 
@@ -225,9 +225,7 @@ get_junit_test_results () {
 	curl -s -o "${RESULTS_DIR}"/results_"$1".xml "${LAVA_API_URL}"/jobs/"$1"/junit/
 
 	# change return code to generate a error in gitlab-ci if a test is failed
-	errors=$(get_first_xml_attr_value "${RESULTS_DIR}"/results_"$1".xml errors)
-	failures=$(get_first_xml_attr_value "${RESULTS_DIR}"/results_"$1".xml failures)
-	if [ "${errors}" -gt "0" ] || [ "${failures}" -gt "0" ]; then
+	if xmlstarlet sel -t  -v "/testsuites/testsuite/testcase[@name='job']/failure/@type" "${RESULTS_DIR}"/results_"$1".xml; then
 		ERROR=true
 	fi
 }
-- 
2.43.0

