Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E287BC36005
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 08:23:47 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.49])
 by mx.groups.io with SMTP id smtpd.web10.43124.1745828620348070399
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Apr 2025 01:23:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=uu8z6Nfl;
 spf=pass (domain: siemens.com, ip: 40.107.130.49, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vyCR1KzaBoOKITiLohXjlr/pJ4pCX39L1ima1HaBsY1d/A0EL5DjiqSzaDagBZ04QuMyV1eZlc0tLXDNS8Yxn7ktmZ/6k9tModyuRYAyHwYJfHj85HvcA9vudI7pCdl6nIr2k4Xg0joNEP+PUB8TIHn+Oa69nul2MQaBwMpeapeWZF8eb2+wUsLOWBK0dPXslQtNAYAPAgJmsSywV+Xdv/GNJStCMJ7PrZtp/iEyS0XIvUqUdaXVb4UE0kVD5YLEEm/cOaKFNDTExc9t6fXI65x/fs/EpmXY81KiWIejH5QazPIFm6M5lSGXs+GpyxzVYCy7zQtd8By7T8RE6ccQcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifKUl1N5GWf10vV10/8oNrRavJhmWMZugnYdatKM1hM=;
 b=zPwUsd5vnQszCUe5B53AhFmqnOCRVvjk97MkDcs1INwn2UjcCEkEXHNaNvezj/uKaluJ1t2ZuhE48e77QnwR5uEjV30aFvICC/CTJx2W1vPJobCEWDINlTYIxP++lNTJgvQxSEmf2P5UoXVNRUkcq5FoYRuJOSGAVreEMUoPqESd8/6qmbbxQ1yoAAs4+MBPFtKyHRDmCaLL/MIzLagw/aQIfHDxwZqEYkgPk7g6UU/Z0Grw3CD0B1dJBI7DLWiSDeO2lsnB8Uw0CI72fsZjM/LmwYu1iufe6AlbJC0Ob3r5Nqq5DQGcSds4BdNbdePlEiXdDIK3w/xi4iANiVx/Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifKUl1N5GWf10vV10/8oNrRavJhmWMZugnYdatKM1hM=;
 b=uu8z6NfljbvjZ21QkJyDs5Wde8x6ngoQ2Xhj3bnghgGlP+Umfix8YTfD3H3GIwr+xwHSkT3fbP60V7R+X8CsvnUbHPIx4z/MU2WxCWYXodBUJ6S4xfkNBmDhCfjoT/sVn9BAS/LwSFehUpkDA+Yp+fBZpouB5047pWUifJQWoDVGww2UvSdI4xieBKJG1WSjxdNniqAuPZmH6RWDGl9LXXD7zZypAENhn1CXxeNnQ5vaNE0XZv7+xa1m3amR2XgLG0NW/O8sJWalZSc0aYxju19gqQJUFQCXBEBzSnaSRkMrJFTOv2kXuLbQ8ST7rxGsJ/ert/+RqMCCL3KpttVmOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by VI0PR10MB8907.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:214::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 08:23:36 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%2]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 08:23:36 +0000
Message-ID: <d8e87b5b-0869-4805-b087-f7bdcbc9185e@siemens.com>
Date: Mon, 28 Apr 2025 10:23:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] initramfs: add hook for data-reset
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20250424092302.2066773-1-Quirin.Gylstorff@siemens.com>
 <20250424092302.2066773-2-Quirin.Gylstorff@siemens.com>
 <79b2bf60-e5f3-42b6-9542-e91ba0bed677@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <79b2bf60-e5f3-42b6-9542-e91ba0bed677@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0447.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::13) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|VI0PR10MB8907:EE_
X-MS-Office365-Filtering-Correlation-Id: 68af5a5a-de37-420b-4bf7-08dd862df889
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MnliWlFzblFPY1M0OVh6UVkwU2xHb0YybzV4SW1wWm1keHFJcC94S3hnK1dk?=
 =?utf-8?B?cytVTDZBZmU4UktTNVlkcGcwYUExVUhVRHhXWnZ1c3RYVXBuOGpZVlZnQkRu?=
 =?utf-8?B?U00zbE9Fb2xWbjVkSWtCVDFnZVVMZTJKcHdUMmF1eWkvdGZGbTM2M0Z4ekVH?=
 =?utf-8?B?UU1OTk9wOUFUK0l4ZEQyVVdEMlkyMkJaMXlKVEdrTktsVFRPTEFqbGM4ai9j?=
 =?utf-8?B?LzFpZGZkdW5EVE1SMnJOK202VGtJUFZJS2tTNzZjV25oT2R5cDJDVmNkZ2Nm?=
 =?utf-8?B?cUlvOS8zVnhqZTlhODFsNDMrRkR3dDYwcVJnQlVJbG1SMkU4QkROeDNVMnNl?=
 =?utf-8?B?RVEzTGdwK3hycGFLVFVFbE5jMldjdU5BRVdlaHdMUTRMMWFJQ21mRmlIVjNk?=
 =?utf-8?B?bkUva1JQOXgyUk9jRnFnV0pFYzBjbk8wVXhmcFZVREJLNTFaTEFGUU1Xc0pI?=
 =?utf-8?B?M3VwSGZjaklzZ25vOGV2dk1KeDUzU21MNDN5U2lzNlVoOFkyZ0N1eEplVTZa?=
 =?utf-8?B?ZDZ4dno1MUhnR1daalAvMFU0S3IrUVBrT3FsdjlMVlh4QTRjV3B0SkJxZXNq?=
 =?utf-8?B?OC9MUW41dVd6bFFzVjU3dFF6YWpOVUtvQ2MzMk1aeFBMZHVmdW40Vmd4Q1ZU?=
 =?utf-8?B?WmpINGsyV0ZZTzFxNzdKSnFiVk9LM0wrMHBpVmp4d2g0Ymd1OTBjOGtZbjZS?=
 =?utf-8?B?NTh4V2lBM21UODFORWRweFdiV09URXJieExRMVI3RVVWRDBCNWx2U09XMzRq?=
 =?utf-8?B?bmJRODcwazF1VDRhcEl4ZE44NjQwdWM0Rlc3eTlpUndreGN5Ny9wdlFEZ2lv?=
 =?utf-8?B?QmwxQnJmQ0ltTEYzRU9ETGpYamZlcWVwa3VIWE5SdzY1a2JIcitrc2I2d0Fv?=
 =?utf-8?B?TExJeXhkSDgxWktWZ3Y0MXowY2lCc1NyaXVQb0lydFl1STVVVU45eFdNRWVC?=
 =?utf-8?B?dGkzMkY3MkRaWTlwQ0JiRmNNQjhaem15YlVicG5ORmZGdHRSUzVhbkNiMHNH?=
 =?utf-8?B?Y202QkQxbWs4cHkrVWNhS0hxTDF1clFuRzVRbm1rNUlGUm5CcGZ4b1J0QU43?=
 =?utf-8?B?STVuTlJrcVVVRHF5ZERLd1drSzB5UUdyanAzNTV4WkM0UWpZeWE5MUU2VVVJ?=
 =?utf-8?B?N0pYYlVQSjdVVUtJcFBTdm1nRXJaMlFyZmxDUW1uanhJTDBnL0hMdzNkcHNW?=
 =?utf-8?B?Mmo1Ym5zMy9nNUxFMVd6dnRsSi83aTVIV09PMnoyaTJoUFR4ZlZQSyt1TXg1?=
 =?utf-8?B?R09yd3RvN29xZCs0R2FBMCtubWhrVE9RQUdtdStXa2t4ai9rWHJva25rNDNW?=
 =?utf-8?B?UkY4VUJUU1l0elUxZHNMTTFueG10YUNkZUlrL0pDWjR0SmdYSG10WlRUU050?=
 =?utf-8?B?T0o1elJmdmUxUE1mRk8rRzhJa2tQZXRGR3NKei90WHZ2eFB3cnVuOTBWQnhl?=
 =?utf-8?B?WVZzYUFkSXJ5WUJOTTZ4RDliTk56WWRhbFcxZmhQb1oxcEZPUTNkUC9rR3Nl?=
 =?utf-8?B?RjZZSG9nU0Q2eUErZmlSZ3pPTDlkckY5U3gvUW92TW1pMWlMMWdZcWRZYXdX?=
 =?utf-8?B?RGdqZzlYV2tBQ1gzOUNMbllOOUtZSW5JTklhV3V2WGloc1NlcmVkdlo1Wnp3?=
 =?utf-8?B?MWRvb0pEaXZzbkU2bmFXbnhENUYxL3BCeTlJeGYyaVVwOU1jeWdNZjhPUUR6?=
 =?utf-8?B?QTlNRFhEMmJwL2tnSEk4TzAvY0lXT3pIUEhPSzVFMEwwc2ZtQ2ZVWktEbmNL?=
 =?utf-8?B?ZDRDc0gvTTMxYzIxZjF4RzYzWUxwcW1LUkszV1Ywb1grdGFkOThCVE4zQlVK?=
 =?utf-8?B?cTZ1d3RGTHNkdThNM1lkbmYveDA5cTMxSXFmK1UvVlV4dk8zNlpjb3ZnU0VI?=
 =?utf-8?B?QnpEY1dBaHN6WnlKeGlUUE42QjJ0VjIxVitZeXppN0tJck9Xcll1ZXk5YnRW?=
 =?utf-8?Q?gvlbY55gNpE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bkhXMlRhQnFSVWJSSDYzTHdPRlVuREtqNGxFcVdBRVhDakxGTFVVQkxwWWtP?=
 =?utf-8?B?N2Q0K3FwV3kwNzBGSEpiSXdaVERnSEw2bTBuYTczOVFmQzNiYUs2OHg3VVQz?=
 =?utf-8?B?WDQ4V0R3ZnZQYXNMUWN4bmNJMEJVVG5Zenp0N1loV01xTU05aGxmZjhEUDM2?=
 =?utf-8?B?L2NhOExNZnRPSHdXUWE4VHBkNDFDVnUwcmVRVzFPOWVhNy9mcnl2Uzh3QTZL?=
 =?utf-8?B?V2VLQkNENUJ3aTNMQ1Njd1lsTk9WT2Z4eDBhQ0tHMkxQb2tjK0kzMUhwb1Zj?=
 =?utf-8?B?cGRFSFdhY3ltTmkxY2R3cG1XcEZiTE9ySjliblZMdVAyWnAvSDIyVkd5VEFJ?=
 =?utf-8?B?OCtacFNCd3F5cEp6a201U29LSU9aU2lDZEc3akgzN1djVnJxS2krUmFKbVA3?=
 =?utf-8?B?VTk2bGJpU0YzUnpsWkNrQkxoeG9CaVRlME5sZldabEJic1FDcWR5MGduWWVa?=
 =?utf-8?B?VnZrWCtNSEhNSFZhY09yUEV5cG5adGloR3RYaGg0THpnSWZIdHo0Lzl3TitI?=
 =?utf-8?B?UjUzWEwxbmx2Qm13TEtiMi8zZmJRQi9ZRklRa2pDYXRTSXBkMFJjWldETFZr?=
 =?utf-8?B?dm5Jb0czbW5naVNwR1lTZWhVYmg1dEhPQ3p4cThLcTRyRlc4cDJiS0tvZmZw?=
 =?utf-8?B?Q1FIeTFMOStnMndKWVlWSjE3TFVUR1lmblFyS1V4MEs3NU43NjBpeHQ3ZE9m?=
 =?utf-8?B?MUYvK2tUZUMxbk5CK3JGSTBwU01YeHVPV3MwYWZPY0dlMklUd0djNnp0NWlx?=
 =?utf-8?B?N2hsT1Jzam5VRmMxc0ZvOTEwMnhRV3VoNkhUQUQ2STdsV09kZXlkL2NVTEVw?=
 =?utf-8?B?NWRwT0dtenNlM2pPUWVSbUQzRXFsT1pzcnRIR3BOVUFNam5UNzZ3S1FSRnlT?=
 =?utf-8?B?RXN6TFF0Nkt2ZjlTUDB4MGlRQjgxSHFSUTRZZnRlVm9xMkcrQTZXR2dDb2hD?=
 =?utf-8?B?cFkxWjBEOTdLbXZLMlQ3dUdCRWFpNU1EQjQ5M25xelZpSW1DYnhZeGFacVF1?=
 =?utf-8?B?NmhhMGdlRStnRXl3amczcWtBUENVTU9FQjErTGZhZlZTUGIvV2Q2dlkzc3p6?=
 =?utf-8?B?M01OWjJaSmh3NVN2a3RWSFhybW9lbTU4TkxId3JZQVozeko2SjcvUURpN3Vt?=
 =?utf-8?B?RXplaGlxRktqSGtVazE5MUhwS28vRUVaMVJWU3IvVXhWcWJ4TjZsZ0dTbUI2?=
 =?utf-8?B?UCtPRk5TaXFqN2pxTlpPcVVSYVdNbjRFQ0VZd3NzOERBWW5FLzdmTkVPUUZk?=
 =?utf-8?B?VDUrMEtMK0ZyczhNNXMrYUxKU0pDNFlHeUpwZDd3b3B2YXJVOUVIUnRaM3Ux?=
 =?utf-8?B?bm9WbG5oT0I4b3V6THlhaXIzcTdkRTRZRzkrRDFueTVmV2xiTzU5VGkvMTdU?=
 =?utf-8?B?YU0xYVF6VUNISWFMcG5mQVV4akM3SW9xK0FKRTQ4T2JmVmNUUmtKV3p2RXdG?=
 =?utf-8?B?bzZBdXRMcHZJdjJGZmZ5cGE5enJsbjh2aGFORXptUjZZbGNFOTdkallKSmdi?=
 =?utf-8?B?a3E4UTMrVHB1b0N1YkNnY0lORWFyTVo1NXc1czRTeWR6YlpDUGRaMExXcy9V?=
 =?utf-8?B?TjM2WGQxS0ExekppRG95TXN5ZHRMeEVYZVFqL1RRR1ZPS2xFREZsMVJBZUcy?=
 =?utf-8?B?N1JMZ2NSS3IyVVh1aERtZHJXNElvbXR0cnVPenVvb2VNMXZmVnRBMXlXRWdo?=
 =?utf-8?B?YXFrQ3JFRTBsbXRGd29rYitzQnVaSHdpM0hGM2RiZ0EyVHJUMTJzbVQ5NEZU?=
 =?utf-8?B?bDludllicUtkUEVxOEhyZjgrSFZwaWlsbForV3ZjUXdXbk5VRTZWYUlhT1lG?=
 =?utf-8?B?V29QQ1phVGxMMVU3czF1aTZWQzNWWmVIQlU1bm1tQVlFUXRPblBMZXhsck5E?=
 =?utf-8?B?aDRuQmVOWTU1RmVaT1ZoQmJQOElTZ1JRY3NRVlQ5N0FGRjVxU21ycU5MT01C?=
 =?utf-8?B?VElVTFk4OU5peTByc3dmckdvT0lpaVBwaktLT2xaRVcxU3pGRm9Ibmx5cFhN?=
 =?utf-8?B?T3ZDYWdQWm1BeUMrSXJNeDEvRkNKY2dJbVRSVURQdG01SzhYS05qMDZCQ1hW?=
 =?utf-8?B?OE9NUFVXMEFISndVajZ4Q2FPZEFRN29uSVFPankrRVI1c3AvZXQzWnNWUVlh?=
 =?utf-8?B?T0dKbnZESUcxU0V5UVhZdi9GcFFaaGl3ajFGSFVmWTVrWmwzVlhNVEM3UGpo?=
 =?utf-8?B?M0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68af5a5a-de37-420b-4bf7-08dd862df889
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 08:23:35.9804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NgvIB/ejjSQhqo51sp22r1DPsojn+cv+LxffLHYw2CXNiP+xBEzeDbLkP4LgYBtuPtUv4pr+T70VfWf+Oyf7Q4smMBSGgGdONK5Zll5QPMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8907
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Apr 2025 08:23:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18690



On 4/28/25 08:35, Jan Kiszka wrote:
> On 24.04.25 11:22, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This allows to reset the device data by deleting
>> all files in the persistent partitions.
>>
>> The reset occurs if a file defined by the variable
>> INITRAMFS_DATA_RESET_MARKER
>> exists in the device INITRAMFS_DATA_RESET_MARKER_DEVICE.
>>
>> This feature allows to add device specific trigger to restore
>> the persistent file system to the first-boot state.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   .../files/local-bottom-complete.tmpl          | 76 +++++++++++++++++++
>>   .../initramfs-data-reset-hook_0.1.bb          | 36 +++++++++
>>   2 files changed, 112 insertions(+)
>>   create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/local-bottom-complete.tmpl
>>   create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/initramfs-data-reset-hook_0.1.bb
>>
>> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/local-bottom-complete.tmpl b/recipes-initramfs/initramfs-factory-reset-hook/files/local-bottom-complete.tmpl
>> new file mode 100644
>> index 0000000..f02f95c
>> --- /dev/null
>> +++ b/recipes-initramfs/initramfs-factory-reset-hook/files/local-bottom-complete.tmpl
>> @@ -0,0 +1,76 @@
>> +#!/bin/sh
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2025
>> +#
>> +# Authors:
>> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +prereqs()
>> +{
>> +	# Make sure that this script is run last in local-top
> 
> But it is called "local-bottom-complete"...
> 
>> +	# but before overlay
>> +	local req
>> +	for req in "${0%/*}"/*; do
>> +		script="${req##*/}"
>> +		if [ "$script" != "${0##*/}" ] &&
>> +			[ "$script" != "overlay" ] ; then
>> +			printf '%s\n' "$script"
>> +		fi
> 
> Will create undefined dependencies between this and the crypt hook.
> Please sort that out.

I will move this before the crypt hook for now.
  >> +	done
>> +}
>> +case $1 in
>> +prereqs)
>> +	prereqs
>> +	exit 0
>> +	;;
>> +esac
>> +
>> +. /scripts/functions
>> +
>> +marker="${INITRAMFS_DATA_RESET_MARKER}"
>> +marker_storage_device="${INITRAMFS_DATA_RESET_MARKER_STORAGE_DEVICE}"
>> +target_devices="${INITRAMFS_DATA_RESET_DEVICES}"
>> +
>> +storage_mnt="$(findmnt "${marker_storage_device}")"
>> +factory_reset=false
> 
> I thought you didn't want to call it "factory reset"?
As the hook does not to a complete factory reset ( the disk encryption 
stays) I used data reset for now. If we add formatting a throw a way
  the disk keys I can rename it.


> 
>> +tmp_mount=$(mktemp -d)
>> +# check for marker
>> +if [ -z "${storage_mnt}" ]; then
>> +	if ! mount -t "$(get_fstype "${marker_storage_device}")" \
>> +		 "${marker_storage_device}" \
>> +		 "${tmp_mount}"; then
>> +		panic "Can't mount ${marker_storage_device}!"
>> +	fi
>> +	storage_mnt="$tmp_mount"
>> +fi
>> +if [ -e "${storage_mnt}${marker}" ]; then
>> +	factory_reset=true
>> +fi
>> +if mountpoint -q "$tmp_mount"; then
>> +	umount "$tmp_mount"
>> +fi
>> +if [ "${factory_reset}" = "true" ]; then
>> +	log_begin_msg "Factory Reset"
>> +	for target in ${target_devices}; do
>> +		target_mnt="$(findmnt "${target}")"
>> +		if [ -z "$target_mnt" ]; then
>> +			if ! mount -t "$(get_fstype "${target}")" \
>> +		 		"${marker_storage_device}" \
>> +		 		"${tmp_mount}"; then
>> +				panic "Can't mount ${target}!"
>> +			fi
>> +			target_mnt="$tmp_mount"
>> +		fi
>> +
>> +		# delete all files in the target mount point
>> +		find "${target_mnt}" ! -wholename "${target_mnt}" \
>> +			! -name "lost+found" -exec rm -rf {} +
> 
> rm --one-file-system
> 
> But wouldn't reformatting be simpler?
> 
That is the question - My first thought was reformatting but then we 
lose the information from snapshot based file systems (e.g. btrfs).


>> +
>> +		if mountpoint -q "$tmp_mount"; then
>> +			umount "$tmp_mount"
>> +		fi
>> +	done
>> +	log_end_msg "Factory Reset"
>> +fi
>> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-data-reset-hook_0.1.bb b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-data-reset-hook_0.1.bb
>> new file mode 100644
>> index 0000000..6dfd896
>> --- /dev/null
>> +++ b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-data-reset-hook_0.1.bb
>> @@ -0,0 +1,36 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2025
>> +#
>> +# Authors:
>> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +
>> +require recipes-initramfs/initramfs-hook/hook.inc
>> +SRC_URI += " \
>> +    file://local-bottom-complete.tmpl"
>> +
>> +DESCRIPTION = "Delete the content of the given Devices"
>> +
>> +# if this file exists execute a factory reset for the given
>> +# list of factory-reset targets.
>> +INITRAMFS_DATA_RESET_MARKER ?= "/.data-reset"
> 
> Hmm, not really a working default if you have a read-only rootfs, no?
> 
>> +
>> +# use labels as crypt setup replaces the label links if
>> +# an partition is encrypted
>> +INITRAMFS_DATA_RESET_MARKER_STORAGE_DEVICE ??= "/dev/disk/by-label/var"
>> +
>> +# list of partitions by label
>> +INITRAMFS_DATA_RESET_DEVICES ??= "/dev/disk/by-label/var"
>> +
>> +TEMPLATE_FILES += "local-bottom-complete.tmpl"
>> +TEMPLATE_VARS += " INITRAMFS_DATA_RESET_MARKER \
>> +                   INITRAMFS_DATA_RESET_MARKER_STORAGE_DEVICE \
>> +                   INITRAMFS_DATA_RESET_DEVICES"
>> +
>> +DEBIAN_DEPENDS .= ", coreutils, util-linux"
>> +
>> +HOOK_ADD_MODULES = "factory-reset"
> 
> What's that module?
> 
>> +HOOK_COPY_EXECS = "mountpoint findmnt mktemp rm find"
> 
> Should we already prepare alternative reset triggers by sticking the
> file-based variant here into some callback?

We could do that.
Qurin
> 
> Jan
> 


