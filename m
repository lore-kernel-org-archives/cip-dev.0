Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CBBD0E6DB
	for <webhook@archiver.kernel.org>; Tue, 25 Nov 2025 12:45:19 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.9])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16234.1764074717322660572
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Nov 2025 04:45:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=H7N5+g5O;
 spf=pass (domain: siemens.com, ip: 52.101.84.9, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbplvS4P0/W6wpervJUHEX1/Mcz/ldvS77NI1Qnk/bda5zeHyhLIJKXBUKa7dMyIzwW0oXl5FB7q++V/gBih3wYFCqHRX1ZTzmqwAdRwUWnrmEFdNEU+fj1LuxQaSUQD86hK0UpSmrfveLEBnSqo6k0D6dr7QuP8W51dvjGc88oGYkiXhSJpV/cbFK/iea1r9gVVXJ2mLqeT2776IYVWZPCgkeeH7RJhBLz4Ggqrug7Z8lkxSGcm8HaHcxvpiPpmi4v7rUnqEsvxkmi7WmB+kqLO4qGe3GQMIjCWq53hs2CFt1tY6o08qM5JOk4hahox/ACSKh3CZNC077Mi8DPz7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxlClugdv+BFAYHsTlIYwUskED+5gjFp0a4jhBsTnaM=;
 b=F5OrzeYEIPFU9vDxLAICJ6+QVOj9w+tAzTGsgR0MWjw2kSR52XvDPUd1+sbLkgOL01CKO4mrn3BxvjkHHG1ioPbHkmqIe53Z1Tk6D5npeYV4h0zVnQby+JRhiEtIUZSo0CknHGU9UAYkPHXaiVtAR6xzWv7F5crWB0Z1dDMOrUpH+A71ZlDPCQccuOffE6ltF71/0HDFDOGuPYWQZlZUJ/5y6Ci+SE1OYNAKJS52vACw7C9oZB8lYVP/7H56SXUvdBEXFxUWL+Vj0Zza7ktoEWTsADiidM7MmAN+ut9007ScowlUO8mmTg4fpQF3liL4ZgxoDhlJwPgaos5cYX0Qgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxlClugdv+BFAYHsTlIYwUskED+5gjFp0a4jhBsTnaM=;
 b=H7N5+g5OolrwZYm9H4q/urCljc1FPdIh91mtgCx7zxbPVzjYp/9AOq3sOJyNJKrApaQd83r9KeDwXmoIpUrcfoY3DFG0H9FGQBVDyi9tZ2+PMRsvhz+QNyw2PSPtOfEiRldF/XS/+pMze9EQKN1yrk42l7YGj+u299wQtUo9VqpvVrq8+7jbDK+y0Puvkp5u1ZonfbJ46vF1X87p15XoryZVBzolYYGtBJoBx339YXNgfUWUcjevhLL+mIrsqCVa5LslTm856ngo3Pe8CiO+cm0Gc43FNicz8voIDhh9VPaQK7HbyALPEHxaWKa2Lh4ZFyHN6CAHNOjfQJWsoj/YHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8960.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 25 Nov
 2025 12:45:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 12:45:12 +0000
Message-ID: <c5e4d7c2-8b21-486a-b982-013cae47d39b@siemens.com>
Date: Tue, 25 Nov 2025 13:45:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH] fix(security): add
 libpam-systemd in Debian trixie
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Cc: Shivanand.Kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro.hayashi.f74@mail.toshiba, gourav.singh.ext@siemens.com
References: <20251124050607.876836-1-gourav.singh.ext@siemens.com>
 <345f8c1e-0166-4946-893b-02dba9dd71ce@siemens.com>
 <KL1PR0601MB4697CEAF6AACC78EAB99E5CBD5D0A@KL1PR0601MB4697.apcprd06.prod.outlook.com>
 <e3ea7e4e-7679-4ddb-9074-fab4f51c8c8a@siemens.com>
 <KL1PR0601MB4697F954236371E6E07F0C35D5D1A@KL1PR0601MB4697.apcprd06.prod.outlook.com>
 <d0b5fe55-f030-487e-b75b-a7fd9d761648@siemens.com>
 <TYCPR01MB9669E7DC641E610491AC078CC4D1A@TYCPR01MB9669.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TYCPR01MB9669E7DC641E610491AC078CC4D1A@TYCPR01MB9669.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:610:52::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8960:EE_
X-MS-Office365-Filtering-Correlation-Id: be1c003a-8fae-4083-8f51-08de2c207992
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WjNkSW5uNkNvYVdVQ2Z5eDhqMmxSRXZ3VFJ5K081ajhwWkQ0alVLQkFEOENs?=
 =?utf-8?B?WXBIUXlFOEhHRTNYNzViVHpCVUVMcTZWZEtyNWRIeXdTdjh5MDdTNkVUZVJU?=
 =?utf-8?B?RkZVcUFaWDZ2WXlobGd1YWt3a1FCSCs3Q3h1aHdwQU9WK0FuN0M0TDBzQURB?=
 =?utf-8?B?Z1RCM3o5bmptY1Y4dDhEcFltSkpHUUtDSURkOUpWUlBLVjIxY0tNMWVSYlRz?=
 =?utf-8?B?UTB2NGI0aldEa3UzelQ5K0g3akc0Z0VKZ0hnakV1ZkhHckxhcnNUdDBIZ0p2?=
 =?utf-8?B?cWdGdzZETXh2eDA0OTlSc2pTeStQSEtGUFBoK1VOaUY5UXdNU1paS0Y0bDJt?=
 =?utf-8?B?MHZhZTNMVGdya09QbnN4d3lHZjBIK2V4ZjJ2azBXR09kSk1lVmliek5SOVpw?=
 =?utf-8?B?c256djAvVzA5OCtSemxubzVHNzc4N05GV3F2MThMYWdpcEZSMm5ReHhLNlpV?=
 =?utf-8?B?SXU5ZVJVVERuZkNyeVJBVys3M2hZZVFkZDVzQkdBTVVsMHE5Wmp5dE04NlhC?=
 =?utf-8?B?bGJXYWtQT1NnZHdtU2hmSEllb1NpVWVQMElPdTFPdG00Q1pmWEFoVGNtUzBT?=
 =?utf-8?B?SUQ4M0dGUnNVRWtvRDhYN1hlc1dJTTJJZnR1QTFRVGdzRnFHSGQ1cmlrYkdO?=
 =?utf-8?B?RkU0bTN2eVh3T1FZMy82ZVVjZ0xvZjI4L3JlQ3RRTmRIdFBwVGg3bFFIcm9C?=
 =?utf-8?B?RmluandKcmZVZUZhRnRGcCtxV1VjbUtKTHpXNk1Ya1J2NmJZL2JMT0I4TE1H?=
 =?utf-8?B?OEpDaWozK3dPaWZkWlFoajBRZVc5VVJPSXhqRHhUR1Z5elJQcTdUYVNONWgv?=
 =?utf-8?B?OFlJbnBta2Zwa0NmNVN0TlA5a3owbHN6ZVU0eGFnYzd3N2toZ2dGZWxJUHM5?=
 =?utf-8?B?dkFDVmNCandvTWd1eitScm53VFZHTzZCeTZncVl4dE5iUGxWZ0VSSllDYi8y?=
 =?utf-8?B?NzJTWnF4YjQ3WGJyZ2FIc1RLYnpBY1pIK3FoRXFSS2ZRVUJMeXJodWVXL1V5?=
 =?utf-8?B?M0NUcWRhK0FHUFFjMVV1dUI3NXVRNUEyOEthOUtHbUhDa3pFUnZaMlpndHlT?=
 =?utf-8?B?ZnJGS29PWFdIL2FVNlo5bURaUHhtYjNzY0dYVCswSnJudGtSS0F2bXFGK2FG?=
 =?utf-8?B?MlRFaHFpKzNLblRuRDFrc0F4cEZ2Z2tRWVI5blhyc1VGK1BIMFpLSDVlMXZw?=
 =?utf-8?B?V3ZBbnVuMkJzVnF1M3d6Q3F4SVJHM1J4a1pVQU1GcWRWTE41WnUrMTU3QnU3?=
 =?utf-8?B?RC9OQ1VvTmJNWTNMY3h3NDBxQ1Z3YXZ1NVpwRE9OZ0xQTy9MK01MeU1RanNu?=
 =?utf-8?B?dGRBdzdONHRid1BwUGdyYnFHaUNxc1F5WmY5cFNUOFV0a1hnT3JrYytXd0dL?=
 =?utf-8?B?V0JDRGtQWnhoczVWUzRIL1FaZjlwOXM5QTltcDY0T1VyWlg0clVWZ05JYmpB?=
 =?utf-8?B?RUI3M1JVQldyRDM3NDhjQ1BsRzJKaVlMVGpnd0F3WmhWT3BKdnFNOHhrV0JT?=
 =?utf-8?B?WitZUW9ndWFyS2xnMGRCbDVFZ200b3RmdzJqZU9SUUhPSmplcC9TM0crMXQ1?=
 =?utf-8?B?dEswYWhUVGx6OEJIWXBHYnZlUlVQVU1adnI1ZmYwRTdZZVNsSHVlQUttSk1l?=
 =?utf-8?B?M0hCVC9sZVhoVXF2dUpKRXRNbkIyT3YzVUtmS1JucFNTRlRFRlFucG5wbEs5?=
 =?utf-8?B?ZnR3YUZnakxRRW1zR0FzeHN0RkZwcyszUzBwMEhCZEoyYTZ0VTE1QkN3K0Fu?=
 =?utf-8?B?L2tmajl6L0RVMitETDJHRnEwMlA1ZFpWWGlwYmJDMEUrQ2E5YlRyM1pGUjhx?=
 =?utf-8?B?RFVIbnRoam5pTzBrNTdZYTdPdUoySks5U2FncjNoRUhjUmZ1VXFZOU02NzBI?=
 =?utf-8?B?YUl5TTV5bDM4R0JoSWcxYU1maXh5ZlgyN0pWc0V4V3Z4SGFOckIzU1pTQ3F3?=
 =?utf-8?Q?AVCX+izT9QcVG53nCnt+elXuxBQCYx7I?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WDRjblZPV2lwRmhBYjZjemFpS2xEQ1MxNUlOZGpab2VISlVOVUdKUkg3Y3Ja?=
 =?utf-8?B?UkE2cXBuLzRJOEFsZUVCM3hzUERyZzYycHFKbG94UW5VTlBTM3ZjYjJvMmJC?=
 =?utf-8?B?TkZIV2Z2V0VKU0dWdWtpODBLZ1R5MUxhT3k4aGZNeTFnSEUxOXYwWmtWeVFF?=
 =?utf-8?B?MXRuOC92ZGtZK0x3U2dueHdlL2FWR0N1WnhzeVJsV2JaNk94OUJPeE93dXd2?=
 =?utf-8?B?RGRwWHJYWHdYTS82Nm95OGhBdW1FbGowejhpdk82MFpERVVuSFVlQWtvN3hu?=
 =?utf-8?B?YkpqMDVwVUlKU0tBK1VtSDZhcGNEZmRDUDdaR1Fnd000WHd6UjBaYVR6UTVI?=
 =?utf-8?B?c1hacnF2QUpld1JxUE1nWnh4T0xMeElIWmpieXFUM1RvODZ1bHlqdlFJbEdI?=
 =?utf-8?B?YjBqOFhTL2NDdGpaVU9LdWlpWnJ4RU4zbWV1YzZMT2tBRERFcDMvVnFYTzZG?=
 =?utf-8?B?SEJZQVBsUDJPQU5wK1d6bmhpSmJ1TWsrQnRra1JhWXFZMFM3RVdvZmZRbEJo?=
 =?utf-8?B?bGJlbE5YMmZRNXZaclQ3OWVua3BlNDUycnVsRitmeG1FUUJQaVczMUcxaW1S?=
 =?utf-8?B?ZnJiMDRjMXBoNnFJOGV1cnFLZ1owSjhlOGROWWRtUHhXbmZycHd3bDVMdDlU?=
 =?utf-8?B?Y0NhSHV0N09ab1NoT3BKeGFUaVE3b3htMGFVcURzTWZXRWtldFhOSnFZWTQy?=
 =?utf-8?B?WmxOU0xUdzlxdjdvbGtDV1UxcnRsaG1yVkZDQ1ovRjUvcTZnQ2VXU2VJLzZx?=
 =?utf-8?B?V0QwOGlvMURoaFJ4WnJRemp4Z29xM0UxdDl0Rjk1RmlkOTRuVzkxVXFuclhZ?=
 =?utf-8?B?K2Fmd09jbURMMFVLNTQ4VmhhTWhEUDB3aERiVEZXQ2o0MzZhZTRVVTZLeGwx?=
 =?utf-8?B?T1BGMlVFanBGQTdMRExxTjdjcG5WMjFROHVCN0xsZ1ZzbFZ6aXF3cEpDRUNw?=
 =?utf-8?B?a0RmYWpObTZZcGFYd3RORmtldmN4aFlmOXE5S0JidHlQTnI0THBIT3p2L3Nx?=
 =?utf-8?B?VHhkak9LY0NZaVU0RW9iODBEQXhQSjVZc25qU0pRaXg1SnlUdkZ2bzRmQjla?=
 =?utf-8?B?V3diVGZ3bDk3eUdvVjQwZ04vOWsvY01IeDZ5cDhwaS82K1VqaUdRNFZLdDNj?=
 =?utf-8?B?aGk5YnhJWnZmS3hUWWtVMDlYRlhyL3lZd2hNRUdteVZHbk5sL3JzcHRLY0pD?=
 =?utf-8?B?T05GdGZoUVdMYmc2WkRXZDVxNmhRSTQzVWNtOFRORHd4U2dQalE5MDBZU3pC?=
 =?utf-8?B?TG85VlhoL3lqRTgxS3ZRWlZMaXRTTy9RNTFzTWZ2NENWZUdtUldKTHpnQkw3?=
 =?utf-8?B?eTVGQnJhamNveGVVNzQxcldPOW1CTGNYUjIyZVlWckRhaE40NnlsVFl5S2Uy?=
 =?utf-8?B?UzhBTkNvQTZWS3dLUWgxa1ovbWtoL1hLMVlxdGljL0dWRU45QWVWU2hNSDVa?=
 =?utf-8?B?ZUNDMFNCd2gxT203SUpIOU9Gckh2MHA0ZnBkZHRTdEUxM1dDOTlJemg1N3g3?=
 =?utf-8?B?ZUlIU2JSQkptN01Xc1YwbmVxQlpiZi9SMHVvSnZPUHAvdWNVOWNjODBPQ0tX?=
 =?utf-8?B?NXFJdnhCQm51SW1uZVpJN0M0WjdGYzd4MTQ3V2dCRWdLMVFBMEZESWNZS2pK?=
 =?utf-8?B?OFRuczNCc0ltR3hPRUE3ekJGc0Y3UTF2V1dIem00QmdaR05GZnNmNDBPc2xY?=
 =?utf-8?B?dHRZaUNIYml6RjBpQ0NBSW5sdEc1TytQOUc4OXAzMnZGS3dsNkR3SUovSFFs?=
 =?utf-8?B?K3VDV0FGZmhTc25iWlJNdmFmTk91ZnpyQjVaeVh4VkJqNWl4cURONVVEeFFp?=
 =?utf-8?B?RFpCS1hVWThmZlVpMU1FZWhETHBlQ2pwbDlPOHdlU1E0a3A2VG9JMTQvSWtx?=
 =?utf-8?B?MWtIMHdWdFQyRjVTSTBRZGhxVi9xVW9jMUdFRm02L1c2cVQya3IweE5tajBQ?=
 =?utf-8?B?SHRBODc3YW8yVjU5MkVRcStVdFV4UElXd1VqMEVCVndOTFhUSGpySC9reXNP?=
 =?utf-8?B?K1JxVnBVd0trODk2R2s5dEM5MGZYZk5sbXlEVDFUSnB0b3YrcEp5OUJjclBL?=
 =?utf-8?B?WktFWCtxZm5pQjFOSktvR0dlUi9JVHE3Y3NqYTNScmttL2hxVlJ6ZjJBSXNs?=
 =?utf-8?B?R01WVzNYNS9SdHM0SUNHOE8zRWMxVzRLcUFTYTVPQ25VV3pOdmZHbXo4YkxF?=
 =?utf-8?B?dWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be1c003a-8fae-4083-8f51-08de2c207992
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 12:45:12.5209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vlTbeyq2OoNg2Jg/AgJjjEYq1InyXxmHiyzSaG2xXGnRUSBwI8TTc9Vzg1NgYowWvgdQa4RgcHzG94uXJEQhEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8960
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Nov 2025 12:45:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20729

On 25.11.25 13:40, Adithya.Balakumar@toshiba-tsip.com wrote:
> Hi Jan,
> 
> Sorry to jump in
> 
>>but we still have a red pipeline for bookworm right now:
>>https://gitlab.com/cip-project/cip-core/isar-cip-core/-/
> jobs/12206266133 <https://gitlab.com/cip-project/cip-core/isar-cip-
> core/-/jobs/12206266133>.
>>I hope it is not regressions.
> 
> The above failure is due to [1]. We're waiting on the updated merged
> configs for arm.
> 
> [1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/140
> <https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/140>
> 

Ah, thanks for the reminder! Let me go after that topic in the right thread.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

