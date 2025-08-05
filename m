Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFCFC87FD1
	for <webhook@archiver.kernel.org>; Tue,  5 Aug 2025 08:56:34 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.39])
 by mx.groups.io with SMTP id smtpd.web11.17211.1754384186408099525
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Aug 2025 01:56:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=JkpY62CG;
 spf=pass (domain: siemens.com, ip: 52.101.83.39, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YR0XQpcLa2gHBXm3OiUqLSd4m+KfkFU6+3lG6t90R93Cf14ZnbqWntoHfOJWAs3b9gQ1l50BIQ+xtvV2sU89qMNfuch8MX8KzAVeb0m48CXY7Eq7Q4KAr4/tR7q5kugweZwhFKHHvA1WPta5FZ1YxRbxVIJ7Fd2A1juwWLuQmLsJ90lPjUejqicy3lnt9EQwlHMu22e3CkXoDMxv5vecb8z9KzIABWp5BlN8ZexEG5ZA9CAc5a6RD7VBVlFSXAapo77AlXmia1pzPdyIV9HxKb/dZzMl/Pom+zxV5O33nTHGDGh/2MrgyNdCrfU0KL/UDBSsWP68/F7ifdD5lH7XcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbNtCWZXTaXZgAFb07TeRupGvHnNTySMKQiU3AZ2k08=;
 b=C2kb7meq3N91iBuPinOChNP1j0RcAhtsRP1J0xgxm8JbaDfPYBdNI4mpEFNmy6NVNFn7EifWssXTNqo4eVxqxc+DKmEbthipG3t/JS8tu81TvXULttPXJ3FZfPh0tw6pM+mdRzzRcZ/p9qaYJNjJZ8SC7me7UqBKt2UZpaDdIZA3k6Qys3LknW/ErC5EFSv6lM6bB2W5XsTi8L+FiOFyXdoum4P5qOxvY3b+4n2l1CD6oXPF3HH2Taze3AAbsBgmT9/pOZtSXqaCcuvs42goQ534J+EvVjQfTl34mm8CklfGdtmtt1bAGbjBzdPfpnD/27JwSbzGI5Ul3TwMlk2PnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbNtCWZXTaXZgAFb07TeRupGvHnNTySMKQiU3AZ2k08=;
 b=JkpY62CGAiwetvwZHNfBxtgRNksjEFsl17ksY1cU9oIUNtLityBhw3imiDrL53GMS9h9QalSz1G0fT4qPMggxtLC28G4QAQTn1nUc6vSbdpMFCt/byIjrxLNOtJG247YR7ySil/UsAjGUyDy2y3mjaw5seGnDL97N1kZprZ45P0Vc9rHpd0qaJ1u26GsMFJv3p7/1yLBsbDoNIUWp+winiAMCg2BF5u00L/8h0Ws+5Z1t7yCratUjhr5YdXQF/yY189mFhhqn0xte/ruF//sEGl2NFJ6a/JEPFwGgBeYQo3jG+W16Uw0XKptBIc2K7y/IwSuq7+unYS170LEVElfBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VE1PR10MB3887.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:161::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Tue, 5 Aug
 2025 08:56:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 08:56:22 +0000
Message-ID: <d48a61b1-347e-483d-b9a4-72c327aaf7cf@siemens.com>
Date: Tue, 5 Aug 2025 10:56:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 4/5] zynqmp-zcu102: add kas yml
To: Hirotaka Motai <hirotaka.motai@miraclelinux.com>,
 cip-dev@lists.cip-project.org
References: <20250718100926.3151777-1-hirotaka.motai@miraclelinux.com>
 <20250718100926.3151777-5-hirotaka.motai@miraclelinux.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250718100926.3151777-5-hirotaka.motai@miraclelinux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::28) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VE1PR10MB3887:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ce03110-8227-4cd5-e8bd-08ddd3fdf33f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OXNTNEdId2RaTzQ2MlhCRmhJRTBWRTJ5L0hRSkVXVlJKRjFROTlCVU1ZWVly?=
 =?utf-8?B?UmhMSzVXVUplNjZ5NmJmWTVnalVWL0d2K0daVnE0SFVXa1QzQ2lOOXlaT2ZB?=
 =?utf-8?B?WW9WT1VQTVdRMGtTYXlNdi9xZnRXTzZFNnczUVR2TXlpYXdldzg1WmZNeU92?=
 =?utf-8?B?b3hmTXRBM2NDOFB0MDVabTJyeGNzTTZ1aW1ZeU5VYWhhRXBSdEtFMVliV0hw?=
 =?utf-8?B?NTRxR0gxZ2Y2czdHb0EzWWhXdjhjYkRsTjI1SU5RTU5wcUtibWF3OHlHanN5?=
 =?utf-8?B?bC9BWTllV1paVGlxNlAza0RmWStqN3FOaFRSR3R6UXh5bDIzbGQ0RGM0RHB3?=
 =?utf-8?B?ZVVyanFMNmRzNG9HWVpiY2EwVE5yMXE2L1JqV0xIVWZIdE1mQjRXenUvMEdI?=
 =?utf-8?B?THdQcVpjSElEa2luL1FqcHc4d2xmN3lZd2ljVSt3Y01LTWJlN1BTUEIyNTdi?=
 =?utf-8?B?eHViNHErNWhvcGtZN1JsTHJLUzZGVUF6NnVwRXl3V3dScTN1RW5QSGJoUml5?=
 =?utf-8?B?NVoxVjhYZ1BaNjlacjI0bmxVOU9ocnVBcGR0MHc0a2lIMElERklBV1VQQmhl?=
 =?utf-8?B?Qm5jSUs2d2ZGNlNZUmJsMURFTUh2ZW5DVE5oMmZoeHloTWUxcXpCaHQ3Y2dE?=
 =?utf-8?B?aFlZdFk1akVCSlA4R1YxeS95N1VWZ05YY281ZTVsdk9XcjhCR1NEbEFpanA3?=
 =?utf-8?B?WFVUTUxUV1lJSFNhZFF5MjNoQmM0T0hyczJwOFNESEhCOVJoL1RpUWlzTEsz?=
 =?utf-8?B?cXg5SE90TXVEU1NndEtWQ1p3bHNqUTBvMDdTTEh3OUN1T3UzNmUwaXMrY0Iw?=
 =?utf-8?B?NHUybDFDTzBUdndjckpBcjZVaTFYZFV6aFBKa3JBVVRaS3lOTk0zSW5pa0ZC?=
 =?utf-8?B?RTEzZnZYZnZDVy93aFN3YStRcFQ0bmxHOStvRzN3VE85RnNtYlQzZ09vUGc5?=
 =?utf-8?B?ZTcrcVhHMUVtT1lnMDY4amJvTm5YblFwQnZrNEFEYXpFN3BrLzd3VXFTVGNi?=
 =?utf-8?B?UlJIL1A0d2JXcVU5QVNXQmxHekNzNGNnTVZpUzBIaGF4M1llMGFEellYSEI0?=
 =?utf-8?B?WG9wTW9neTVMS1JKZDhaTjJ3QW9YQ1RsbWtUbTlrSlZwaDQ4VjJ4d01hSm8v?=
 =?utf-8?B?eVQ0bnV2RlMyN2huMlhUY1lJcTNrL213TjlVbHkxVWQ4TG81a0ZlVmx6VEZS?=
 =?utf-8?B?VDNyRjhZbHk5WjE5a0djL0JHQXZCMFZYa25nK216c1pDVEVHM2R2SlNGQWdH?=
 =?utf-8?B?akxDdmtWK2dwbStodzkxZ0l2bXF6R0w4NXpKVHpacXF4UFpoVElHRWZBdytx?=
 =?utf-8?B?dTJGbHoyMVh1RmZGeGRWTDdyaVRqaEhmdXVYQklxQ1grZndhYVpNSWdYMHg3?=
 =?utf-8?B?dTdYVlVUdGxTVUlDVVUyb3BEZ2pCeG5seC9zbkxsSjUrcGNKQjFUbEhXcFRV?=
 =?utf-8?B?bXl2Tkd6Q0RydmhZVnNnQVZpZEMvZGNxdU0vTmtSTCtpMzNXWnA1ZHRZTy9u?=
 =?utf-8?B?Qk0vT3hLQUNPUE9QcDFXQzFpblpoM25sWjU5Ynlib1VpMmR5ZlpqV05HMnBN?=
 =?utf-8?B?SUVvRlNKSmVDM0lRUWdPUnhzODhUSGl0VUhQV25aVHJ2SEtqZnlVSFB2UndV?=
 =?utf-8?B?NWx4TmwrRzIvUkVZd2p1TXhib0xkL056MENUMkMyMUZzamcrQVMwM1V2NVFn?=
 =?utf-8?B?MExyaVJYbEg4RnBXZzNGRk02STZ4eTN4V1FheUhJMlpvb2E0MStLTEN5Vys0?=
 =?utf-8?B?dnprdHowYVJkZFNRd2Z2eUV3bXhEM2FqeWMraWx3SXA1OTdBS3RLZlkyRWY4?=
 =?utf-8?B?cXZQMjY1UVA3cDJZWng1MlNTY2Vrdi9SRERhVmpKTnpGM0g1Z2RvWkFhOTBn?=
 =?utf-8?B?Vml6d0t6NjFuR3o4QkJscDZWNk5IdXBxNFcyWHpaRG1RdUZsZ1FlL3FURkxZ?=
 =?utf-8?Q?r7KEA/tLTlw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UTJ6OGJ1WDBlbjRwbWZUeXA1TGFtSlZYemp1YytITnVaQ3lJUlpwblhBVTJn?=
 =?utf-8?B?ZWx3VVZkUzdXUEtPR3NBZ09Dd2Q4a25XNFViS2R0cTJ5ZFIrVWRmZ3NRM1RZ?=
 =?utf-8?B?QXJqZUowN0l5eGF2aTJ3NVVXTGVhYW03NHYxaTQzWm8zcmRJZkJKWUtjYnFz?=
 =?utf-8?B?a0hwL3FsWWxpc3p2U3IyVVN1M0xNTGt4dlh5c2QvTCtQclBaeTVScUoyOVAz?=
 =?utf-8?B?ejRJQWxTNnA3TlBXU05zdytBTzQxdWdYd1YvdUhab2pIMDBtbU0xc0NJRFdm?=
 =?utf-8?B?Zk55VHRwNWxIZUFhOE02U0NGOUkzbkc2Z0xJbFA3cytKdDljcE01TVNEUml1?=
 =?utf-8?B?bTh1bkpreGRnbldMakFoMk9YRUFJYjh3Q0FqVzcxNUZCcDIzU1MrVHBvVm1V?=
 =?utf-8?B?aTJSUWFiaWJQN2JQS0ZkeSsxVk9JdDdJRjQvMzVNMkJwbnQ4T2p6Q3ZXbGhB?=
 =?utf-8?B?aEk4d1JKOFovMSs5ZXUweW5pNnNSaGZMcmtCMllncDhaYnR1dG5mQ1pIV2hJ?=
 =?utf-8?B?SXloL2RaMXd6YityRlhBejFBdkNLcytQcVRQMVUwS01neWVNTmNuQjN6Y09x?=
 =?utf-8?B?YUdsTlBWek1HRjRwU2RxcnZkYkJSL1grQzBWSUp5LzNHellDUkc3WG5PT0dt?=
 =?utf-8?B?cVVPK2dTOEJLMXpHVXE4d3NVRS9rYWhCbmw3TVMzTUVWTVVHdGZ0dE01dnp0?=
 =?utf-8?B?SXlOQXdNMWc1NkNhcU8rMjBHZHg4bVRiTHY0NkZtV3BwbDlvNTE4NGpaVU11?=
 =?utf-8?B?YVRiMVBXUjNvVlUwcU1ZQlNDNDlOQytYREJNYldkdTNuMWVpaU1POC9CU0Nh?=
 =?utf-8?B?emNWWlNjK0VsQisyR3g2RDZXalhrMDdBak9xQ1JTMzhnVzlEZGFrc0ZrenV0?=
 =?utf-8?B?cmJHWVJJZUswM1V1VVBYT3FLODQreGhwRnZlZzJFR2NzbXRHTjl0bWhxMFd0?=
 =?utf-8?B?NmtuTVJIT1ZkeXJpUEp5NFo2TTFtSlYrc0NoVXRoaUpobTZsTyt2WGMxbUpz?=
 =?utf-8?B?ZzBFMXcvQTRQaG5LQWtQSzdkakxxUHN4MGtkbTc2ZDZsMm9oSmR2QmR3cThZ?=
 =?utf-8?B?WDlsWnVXbzVyQWZvMFFVb1RINWdFQnZHNFRGdTBZRGhSL3ZhakF1WmZ2TjQ5?=
 =?utf-8?B?N0c1eXFYUmdqYlBXQUx2bHhHcUVtTW1iUUVENUF3RUQvQUhjd0xKaTlhVmUv?=
 =?utf-8?B?N2V3UHpmNlVCYXhuRHhYU1h2NHB1TXZ5VmR4KzJya1dHdkNkUTNBMW8rZTJ6?=
 =?utf-8?B?dXI4VERBMlN1c1Q2UDBmMGVEQ21NK0RHTlJPajNyR1Fad3FnUU9tS1lkTFZx?=
 =?utf-8?B?b2J4UndscEhSNGh1Vk1TdUlvVE01TG9JS0FuZTJVNGFsZ3g4ZTQ0WlF1cGxM?=
 =?utf-8?B?OEJuS09vMStsM3BVa3RSUUNUQzRFdGtWSTVPc3BCUE1QKzRJZXVvSys5Sk9X?=
 =?utf-8?B?d1VucmJLcjBxUHpBclVYSU95WEE5aTRCakJuMDdOM3hQNi9aSndxR1k3WU9a?=
 =?utf-8?B?VHNyWHF5RDNHNTloeUNBVFR0VWxjK25SekVTM1BTekRSTXRieFJjN2h0Tk84?=
 =?utf-8?B?ZVpEUVRWTm1wLzgxdi9WZGtwcU91ekJFak1LRkVpckVaZTVvMU5aTlc5TjFN?=
 =?utf-8?B?UThZaWR3c1pKNDhPeStpMDBXcUZ2bkFydVdjU2RGaE5IbmFLMEkxa1l5ZWZV?=
 =?utf-8?B?OERKdS85Sk9DQ25qN0VHbzdmS3g5dllKcnBsOTl0NHhFY2pXUlp1TFEraURP?=
 =?utf-8?B?cWJHTnZuZk51MHQ2N2kvaTVES1plRTYzd1V1UmJwNStIUkxoSmM0Q3N5Rng1?=
 =?utf-8?B?Q3A2S1RnZUplbmdSSHRmRVUrbEsrTFNNek5vc3dvZGtxNzA1UHZSVEV4QVpS?=
 =?utf-8?B?bm9yclhXdWpjZEwxeWVaM1dzUlRKRTZTREQ1cEpxU3hobCs3aXUxa0xBWHZP?=
 =?utf-8?B?aXhZbXF4ZVVtc0wrb0ZwRGxldlBHQ243VlFhTkM4MldHN2d4c2JvUitGV01M?=
 =?utf-8?B?Wkt4VGFnYXF5YWdkb0RDcTh0aW1ybzVnQ2FFMFVza2piUHE0YlA2YUJKeXo3?=
 =?utf-8?B?ZXFHZTFoQXB1WmVGcHczRnJjTlhoSVR5WUF5cHNXczRBSndhMGdXUGdEQU9L?=
 =?utf-8?B?VGJUN0tuaU1hOE9qdTJ0cFp0YUJ4dUV3TlVMRC9OODBzWHdqVU1BbXU3eEh2?=
 =?utf-8?B?Z0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce03110-8227-4cd5-e8bd-08ddd3fdf33f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 08:56:22.0438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uA/Ihm9juPzDfrHvZFIo/kaKiLFLr/4kQMzK/Y/c91T9VOMpsEpFTetHbu0i5NlEdp99igveuZvEDIZ5Rmfh9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3887
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Aug 2025 08:56:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19664

On 18.07.25 12:09, Hirotaka Motai wrote:
> Signed-off-by: Hirotaka Motai <hirotaka.motai@miraclelinux.com>
> ---
>  Kconfig                     |  5 +++++
>  kas/board/zynqmp-zcu102.yml | 16 ++++++++++++++++
>  2 files changed, 21 insertions(+)
>  create mode 100644 kas/board/zynqmp-zcu102.yml
> 
> diff --git a/Kconfig b/Kconfig
> index e0788926cf12..5c9ded15136e 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -57,8 +57,12 @@ config TARGET_HIHOPE_RZG2M
>  	bool "HopeRun HiHope-RZ/G2M"
>  	select ARCH_ARM64
>  	select HAS_SWUPDATE
>  
> +config TARGET_ZYNQMP_ZCU102
> +	bool "Zynq UltraScale+ MPSoC ZCU102"
> +	select ARCH_ARM64

Do we support that board even with kernel 4.19 and 5.10? If not, make to
exclude those kernels when the board is selected.

> +
>  config TARGET_QEMU_ARM
>  	bool "QEMU ARM (armhf)"
>  	select ARCH_ARM
>  	select HAS_SWUPDATE
> @@ -84,8 +88,9 @@ config KAS_INCLUDE_BOARD
>  	default "kas/board/qemu-amd64.yml" if TARGET_QEMU_AMD64
>  	default "kas/board/x86-uefi.yml" if TARGET_X86_UEFI
>  	default "kas/board/qemu-arm64.yml" if TARGET_QEMU_ARM64
>  	default "kas/board/hihope-rzg2m.yml" if TARGET_HIHOPE_RZG2M
> +	default "kas/board/zynqmp-zcu102.yml" if TARGET_ZYNQMP_ZCU102
>  	default "kas/board/qemu-arm.yml" if TARGET_QEMU_ARM
>  	default "kas/board/bbb.yml" if TARGET_BBB
>  	default "kas/board/iwg20m.yml" if TARGET_IWG20D
>  	default "kas/board/qemu-riscv64.yml" if TARGET_QEMU_RISCV64
> diff --git a/kas/board/zynqmp-zcu102.yml b/kas/board/zynqmp-zcu102.yml
> new file mode 100644
> index 000000000000..4663d8858a88
> --- /dev/null
> +++ b/kas/board/zynqmp-zcu102.yml
> @@ -0,0 +1,16 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Cybertrust Japan Co., Ltd., 2025
> +#
> +# Authors:
> +#   Hirotaka Motai <hirotaka.motai@miraclelinux.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 14
> +
> +machine: zynqmp-zcu102
> +

Extra newline at EOF.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

