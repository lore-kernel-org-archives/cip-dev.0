Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93465C2BA1A
	for <webhook@archiver.kernel.org>; Wed, 19 Jun 2024 12:06:23 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.80])
 by mx.groups.io with SMTP id smtpd.web10.19290.1718798778847190221
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Jun 2024 05:06:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=gtWmijyF;
 spf=pass (domain: siemens.com, ip: 40.107.249.80, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NP3Aj753NSSDpccAx2CJr+8EdyO+k5ZNcv8dmseEKT2mV/9OBkgeakCOvDWp6TYcuSwfuD7zXeubhMr7Q8oDd/uXq4I4PXzt+tRFm8tDqEG59ytH7yNXMuWvlizbYscWsSiCdmQE/UYWddSLXreiRV/uThkMO6FhGqvJHVcfCYZ6OU9QTyCDA4m5dShJ7zPUXA1FiPOGLfvkV0Lpd7B23xcGf+R1GbOmV2f3hVed4W00Ri994OOfBsuum17wkX65eSKecqcoShcrDCJvX7zAjSi22bvjL4cxPGwoUZrhOrOQ8hYc8BZqWITMldAlabcnthf5m9WvhNOyXVkFuHh6+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2q1peUvN3Sbh+LduuNJXTm9/Z++bvKVo40UC2vskLuk=;
 b=K01ZeQfpRtKq5PJi6VwrFFgVfdRw9wwT9tJ7ji/scJnFNozjgfryhW8uyJOmmSDuATfUMUHZ6ahpoqS+8kKfN72tVE3kPbGi3fbLmcewL09qa3ziZzM2+P/JF525UK6kLcI5uoEKQr+NpypoF7R9GcdIl+wscTJijWC6vtyiy/NNDoux2qiI2WLA6lOllJkUQsMEi4A2oLEMdS2941yi+m5UablkSblZHYeqauOSxFRQlRaAXp9QGcRGYwMUfUghLsgigXVcuHFX/JmJYLqrYCNVJmguAB3d0TT4pwb0WN+Z2nzdLbozOuPEdeAgFnEqyP7oKJCKP+l52jmrHzyycg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2q1peUvN3Sbh+LduuNJXTm9/Z++bvKVo40UC2vskLuk=;
 b=gtWmijyFPkDqxFNeQijsle8S4jvCR6xq3GZiyQ6fJuuIDxFFTWv2n1cdpdozHikCD1uprCy89EN6R3dxs3ZzS5h96g64ae4LIOmKvsOmeogvmByauEmVkktvqBCiXbv2jAoXGlCsRMo+UO7kNvIbT20qeWU6XVxBxNox0Y2v5xfEURQ3KnLP3RxWKWqvOAKuP0xXxG3LITVRoIIrNYG9P9GnRK7e/pQ3Xtm7DRTuKmNiIsCl5NwRhPiBic2ibc8gGugzWsBkZIBcgOqqhsjOApNAZ8GIaUN/p45cZC9zOsHNIJZg3bKvzKbzBMZnT4LbD4mxJ5YuYnPtIRV6jOo8hQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3680.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 12:06:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 12:06:15 +0000
Message-ID: <1c9ef742-edf2-42dd-a815-f1a82fa3e46c@siemens.com>
Date: Wed, 19 Jun 2024 14:06:10 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Add missing wic file for x86-uefi secureboot
 case
Content-Language: en-US
Cc: "Shivanand.Kunijadar@toshiba-tsip.com"
 <Shivanand.Kunijadar@toshiba-tsip.com>,
 Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>,
 "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3680:EE_
X-MS-Office365-Filtering-Correlation-Id: 04a451f7-a193-40f8-c396-08dc905837e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Yk5QRkZQbm5kOVl0b01ZK3N5aGVaVkgvejVWcEJmWWdsQUFUOW5IUjByRlFm?=
 =?utf-8?B?NGZMVG9oa2g2UkRxSC9La2NMaVNwaklWUElzcnNwbVJaOFZtS2xNbDJib2pS?=
 =?utf-8?B?NTZ4cFpaMVpiMnRjSlhlSTBLaEY5aVZPYUpsY2h4NHlHTXJESW1XMHdtQUNs?=
 =?utf-8?B?Y3dBaXNyRVNjd1NseURJY0xxcE5IMGR1bmQ2UGw5ckxMNmxXaktkOHFMRVM5?=
 =?utf-8?B?eEhGWVZHTGtlTm4xQTBrK2FKMjBjZXZobDRxNCt2RXgwT0Jxcy9udHRRTVl0?=
 =?utf-8?B?MnVRTFlNcU1OL3VPV3p1QU90R3REKzdqK05adVR0OVZ0MzJhcFpBQk1jWGcr?=
 =?utf-8?B?eDVOT3VJeklSQ2pWRDZ2K3lnbWRYYmtldC93YlZBc0JFZVBtUlpiU0JpUFcx?=
 =?utf-8?B?eG5rczZSV1JrVGtoVXF2ZE1Tb0pCM1Urc01DU2ZYazhVTU9QdkxhN3UxcEhx?=
 =?utf-8?B?L3M5NnpKa0tVYmJQdENPZ29Pb2JXTVQ4S01SUnE2c1k2MEhUUE9YemZYUmJH?=
 =?utf-8?B?Vjc2TW1ZMUFvbnhrWmg1NnZtaGlNb3U5eklZL1Z2VUdqSGhiWDZKQjJ1dzRC?=
 =?utf-8?B?OWhCWEVUMEZDU3o3ZVcrN1BTby82cUZSN1hOakhuVnloYlBVRFM3SDNzUTZQ?=
 =?utf-8?B?SXpkUHB3ME90a0xUTjdsNStSWnhoam9zQjF3TU5oVDgvcld0RkJ5bkdFTGJU?=
 =?utf-8?B?V0pBZUFXRVJpYm9rRjFOY2IyOUVQWU9OMXJsd0VGRGZxcFJhaEdXakhsSThl?=
 =?utf-8?B?TkRaQU8zMlBOUXJyUnE4QkJqcnJQZVFvQ1I3NjNqa0xuK0packdSR2pJQ1Qr?=
 =?utf-8?B?b0xtby95bzZMN1VoRVp1L0I0ZGZxS29xak9OZXBGd1RJdEJjVWRuSGowNytR?=
 =?utf-8?B?ejVaaWsxaUgzWkxyTkNVUGp4UGhXb3JmekFTK3drRkFiWkw0ejBpMDBFWXFq?=
 =?utf-8?B?Z2pOSE5WNWlmUC9FRDRVdzBhcHlWek5XZWJtV1lDemhLd0d5RlU1UlpiSFVG?=
 =?utf-8?B?Mld0NnMxWVRySGF5ZFJIcjBmK2pKZWQ3ek5vbkRZK1YydGd6VmVSOWlBSlAw?=
 =?utf-8?B?MGU5VHdoek5Ccm9raENqK0QvWkpPQzAwOUhDSUNsdk1OcVJPaGdVa2xQN1pa?=
 =?utf-8?B?eEtxNHgzZHpZUEQ2WDNJS2ZWeHRXbUhDV2JIQ2UwRm11RklRVTZlbzVIMkF0?=
 =?utf-8?B?OE01K0xLMDRaRHUwM1FXMzN3RFMyWURiQks5cCtGMVZzVjFpL1l6ZGp5cDRa?=
 =?utf-8?B?VThhYnIrQ2U5ME1WYitOL0J1SURRRVduQTZOa1AvT2ZtMUVoL09BWk5YRnlN?=
 =?utf-8?B?VzZ1Z3NzMDVmeW43VEdWWHNtRDJQS1ZQN28wbi9aNm8xQnA3dFp5bUpxZWpK?=
 =?utf-8?B?Z2lKbGVCY0JJYUV1eGFvVk1OaUJmSEg0SWJjakJTMEpNQkZ6Z0hGWGFCbEdQ?=
 =?utf-8?B?a2tpdXhPTCtmTFB2OXNkbTRWbm0yZHQyMlh4Y0tmUHNxY1M5Y0NrRWpXcmo0?=
 =?utf-8?B?eDd1UkoxSlZBd0xWS3pUeGh4bHJDUm42TzN4bU83SFdDbGJNVXNWZUtNa0ti?=
 =?utf-8?B?UjFIMWY3ZmMzeDA4eXhPdEJmZ2tCMC81L0gxWWwyb3lySXoyN0Y1bUg1NC95?=
 =?utf-8?B?cUVkeE5tcE0rLzZNR2RPVE81eTdaTEQya04wbHc5eGVzODdkOGxnekMxK2dx?=
 =?utf-8?B?eVZmcVNBVEhCMDhjT0dZYjJLbE1vRGZJa2lneFZUT1YreG5VZTBGTEM3RmUr?=
 =?utf-8?Q?+5TGdb8pUW6V0cSjSVUjSozaxoWAH6nmmxUIxbj?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bjhJWmVaRDY3R3doRm83Tm1MOUxXVnNhVEJrUTAwTEtvZWRGMXo3UStoa1NN?=
 =?utf-8?B?RXllN29JazhDUTJkdDcyTWJmWFJBMVI1b0w4NGdVdCtheHBWZEh2TmZkd3Yw?=
 =?utf-8?B?NnZpRlFJMEVJc2ZQNEc2M0ZlM29XNjlTWDN3dlRJSUxiQU1pNFpYVzRlNHRO?=
 =?utf-8?B?Ym5YR0VFUHBKeDFpWDhTT2NWSjRTcVgwZmNwM3BtTXl5VXFMZS9xM2o3Q0c4?=
 =?utf-8?B?Y0VneWFhQ3I3dm5nc0JBOHJ2ckpQb2o4OFVZMEplSjZLUjVIWjRRZ3UxUi9u?=
 =?utf-8?B?dytMUVFYWkNKTjV2WEdGK2JiN0sramZjWVNxdVlFL2RraEdwYURCTkdYZmZn?=
 =?utf-8?B?VU5FOWFCZFE4WkJKRjhGSVBONU13OFNlaXNQVDk1c0k1eGxDVVNBbmtYOHgr?=
 =?utf-8?B?emtCRUFpdk9tM0djOFhNalh5eS84V0pjT1lHamdjY1FYbUkwZGM0QnJlZnU0?=
 =?utf-8?B?Ry9kYjVjMGVrcmxUYkdncHEzWVM1ak04cFJLSm5TS1ViLzhWQzlIdFpFMkdB?=
 =?utf-8?B?WHVoeXR2am52V1F2eVFvU1VudkFXdWZJaHpyYU5ZWGNwOHhYbFZ2Zk95eE1Y?=
 =?utf-8?B?Z3EzUHBoRFQrMThnM1lReGZ0ZWhUVTRLOERpd01ieGpoZjNtSGt3dkNpRFpR?=
 =?utf-8?B?endST2NUSCs3aWpmUW12bGxGcGM0RkxuSmVsVE5GRmVsVWtJNW9wM1hHRXVh?=
 =?utf-8?B?bFFDcEZqOE1uTkpSMmdoejVIdkZ0MW1HS0dmNjkwckhXWDlJdkdHVDBGaTJw?=
 =?utf-8?B?Q3VzOU1oK1draXpBUG9OdVJIVjc5RGZkd1prOGFlRUdXTTFyNldGa3hTNm9U?=
 =?utf-8?B?bTdwcGN3RDVEdnJkWE5ZR0xIZnZpR1k1Sms3NGVBR1paSEI2SjdwaGVOTTVP?=
 =?utf-8?B?MDdmbmE2eGlBSjU3MEprM3VabUdMOUNBcVY1dVU5eGI1VUs1cFhManYrS3Ji?=
 =?utf-8?B?YmRrM3liU3pRQU9jU1Nta1VZY3BKRis0SnkxQXFaZFM3QXM2OUd1bXgwNEZh?=
 =?utf-8?B?RVdEYURTOHBONmwydVZVUm1KUm9MbjhRQVdjaWtaRWduS3VDWndMS1N6Y3VZ?=
 =?utf-8?B?b1dlbGZSMGFlc0dNcmE1U2ZhSzJyTWE1MHNUSzdrQng3bFBLZ2QxeGFmNmFF?=
 =?utf-8?B?cmcyRnZpU3IzNWxDLzFTSnI1enJUTkpsTkFxNnBGdTRBd2tVdUZ2NFVuV1pv?=
 =?utf-8?B?Nm9tSXE3WlZNV0VrQkM4ZHBlVnUrNTRWeTVZV2lENWU0aG1semZMa3p3WSta?=
 =?utf-8?B?NWtKUDhMYWtnQVJYclFyRVlGYUdMU3lLM0pPYVpDRU05NE1HMVlRQXIzS3gw?=
 =?utf-8?B?UVRneDBlRHF5Q1NLWjZhUlJvUVk3TVdGbGZXU3d2eU52SHc3YSs3Y29xc3VN?=
 =?utf-8?B?S0ZHTnJyTEljL1lGaTdsUisrNEtlRmZQQVEvMnhMeWpNOC80Z3BGcW5PRFpz?=
 =?utf-8?B?ZTA4RWFDckVwV1U3QlpvMmM4VitFU2w2ZE5uNFdDbDZXeWxKS0xZTFliSnpq?=
 =?utf-8?B?elFaRGxOWlZ5SzNSa0hBVStzMlkwcGYrbTFhd3NPZHRmcFRBRG1YOWE3NWFS?=
 =?utf-8?B?eDJoM3B1Q3RJNXY4UFNiTkdYVTRUQjEzTkhGVWExTmRuNnFhUVpud0k2V1pD?=
 =?utf-8?B?R1YxY1FoMWNsM3dpT3NuV0pST1V1MS9ZdzFEeld2RnpUeTdGT25JSW5LTUMw?=
 =?utf-8?B?QmpBaXZodmN6aDFHTlE2OXVWczhkQWZWT29DQ2RpS1JnWm1YOHNZcGdla2VX?=
 =?utf-8?B?N01VOWYxRFFJbjlIc09lTXBITlFCMk5aYVdZejE1d1I5YjlrbS82a3FBYzdC?=
 =?utf-8?B?UzFad2l1eHFNelAyakdKU1VWM0dqaHRCYTcxeGFqTGtxTFNOTENuK3lkTGdN?=
 =?utf-8?B?YllDTlFjTUtUc2pVWWU1NkgrMTBmaHBRNEhMblR5UWZOVGJMOWdTNjNuK2I3?=
 =?utf-8?B?eEVEZXdRaDZ3a1BFbWIvWVVUWlBRQnViaVJuYnlEc0l0bUtMb1BkelBhRFph?=
 =?utf-8?B?Ty92NVFraDF4bXNtZE1qcGI4dEQycnNGU1Z2TEJ2V2JGaFFkOUNIZ1J5YTZx?=
 =?utf-8?B?RllEWnIzbG0zckwwcWw1NDRyKzN0VVMxdVdZK3g1L25YcHhzVlVlQnc1MlVB?=
 =?utf-8?B?dkw0MjBoZXBoSjQ5aGdYalIrMUcxb3gyTVhsTGZvN1Vta1Y0NGpyODRrRXJu?=
 =?utf-8?B?a1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a451f7-a193-40f8-c396-08dc905837e5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 12:06:15.0031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDRLK5Mh9vb+uPYrAMPpg/8+xmbW1mxsOyklMW6shg18SvBnWbuFqzjuNz6H20Gz9XJWaDAUyWAqa+n1drHl8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3680
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Jun 2024 12:06:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16294

From: Jan Kiszka <jan.kiszka@siemens.com>

Reported-by: Shivanand Kunijadar <shivanand.kunijadar@toshiba-tsip.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 wic/qemu-amd64-efibootguard-secureboot.wks.in         | 11 +----------
 ...wks.in => x86-uefi-efibootguard-secureboot.wks.in} |  0
 2 files changed, 1 insertion(+), 10 deletions(-)
 mode change 100644 => 120000 wic/qemu-amd64-efibootguard-secureboot.wks.in
 copy wic/{qemu-amd64-efibootguard-secureboot.wks.in => x86-uefi-efibootguard-secureboot.wks.in} (100%)

diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks.in b/wic/qemu-amd64-efibootguard-secureboot.wks.in
deleted file mode 100644
index 0f4d6374..00000000
--- a/wic/qemu-amd64-efibootguard-secureboot.wks.in
+++ /dev/null
@@ -1,10 +0,0 @@
-include ebg-signed-sysparts.inc
-
-part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
-part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
-
-# home and var are extra partitions
-part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
-part /var  --fstype=ext4 --label var  --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
-
-bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk watchdog.handle_boot_enabled=0 iTCO_wdt.nowayout=1 panic=5"
diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks.in b/wic/qemu-amd64-efibootguard-secureboot.wks.in
new file mode 120000
index 00000000..d61aab3e
--- /dev/null
+++ b/wic/qemu-amd64-efibootguard-secureboot.wks.in
@@ -0,0 +1 @@
+x86-uefi-efibootguard-secureboot.wks.in
\ No newline at end of file
diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks.in b/wic/x86-uefi-efibootguard-secureboot.wks.in
similarity index 100%
copy from wic/qemu-amd64-efibootguard-secureboot.wks.in
copy to wic/x86-uefi-efibootguard-secureboot.wks.in
-- 
2.43.0

