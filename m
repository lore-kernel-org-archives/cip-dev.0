Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08AEC79F82
	for <webhook@archiver.kernel.org>; Tue,  8 Sep 2026 10:49:15 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.61])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4422.1788864546610751845
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Sep 2026 03:49:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Wxd72ysp;
 spf=pass (domain: siemens.com, ip: 52.101.65.61, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Na9E1ooDorW0+8ib6fDkeY74iEdBVL9zN44SKJm/ctR6DP8mXrh/IyO0qFlH7Bir+it2AGW4SrJD2pIx0v7dUnkOWNfzFfjh24J76PsyIBiF6TIUQaP67kepFBe5DoI5Er7xgkj+q8wE4d0Ip+5Z3NL6e1GOhmWEASW+y2k0pSwquUfRngZ1OnrK45498slU3nsNazXbHkddopQuKIJ21UuRLCEIWY17tA2PEjoR5Zl9GgUhJCBBAAhXNgdyHE8I2fiX49QdlhT4MXlUjd1WfxEn/WOT1xSSooOpwdFM5Q3DQhUpdrmdemaDStdEJ45DeSWAnhYzN8/VT+RX5YcUVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9aJwNk8vn6DN0ypuGw4xDFB7ASm9ZSo0UenRYjMCGA=;
 b=XXJYJU350abtfg93YS29AtU7B6LiurONgZ3Ui+cOPFLhvMjIF/nrV3TfIcNKO57xQo7MFC1gbZbPFCpk/oov8qyIJ5bHFLprgvPKWNvddcmDBM0HNKXrvcNs1MKNT8IbxzWCt6uziJV3Dm9lcYApkxiSHNSnqQ8HyMpsNDm0CEB3Zgldcj+XkPa3lKJUAN1FjjyRI6ryakf0YZEqm6nO5YbItJooTghxmWpckpvoVc0E594swoS4Whz3+5gMlF43DB+Eg6/6EQCszfj9+3RD3ejL1KJx2mBSuV4ra4jEsmAOZG2ooaZe2wkcE68lFbylS3f3UIybM/a7os0tlqOBZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9aJwNk8vn6DN0ypuGw4xDFB7ASm9ZSo0UenRYjMCGA=;
 b=Wxd72yspgYG3w7AQjWCrV3Y9PsWRL+j+lVyzrmutITlJJkC1GjWW3KplMSoqD9RBrNfI4wTJtJS+sXrZxJ2IlVOS7BlUqlphzZ/Ijqb3p804T1HP8i0o2eLncAU6Vo23+q7DKievl/2E5DFYONxLpDwzW71P43oi/itT6wEMMaAipdu6b1hYjJ/6ClRL3E7hDioXa2+BLXMaBXm90wIhHOYG6vFgh+SsIDOkzZdmrf8gL/s/FmMB40XAEvJsZrlrsfYa16OUE7/GJhFzX/2I77S7eVuMx4DLrvSybevHEOYx1tympBz/MMkjh48x3cBPHANhmVqrkEwRMpmpH4TJjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8131.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:114::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 10:48:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:48:41 +0000
Content-Type: multipart/alternative;
 boundary="------------UkWoJ8zSuPRM4qT2MdQHIXV9"
Message-ID: <66bbd34a-37be-4ba6-a691-339efdb2996a@siemens.com>
Date: Tue, 8 Sep 2026 12:48:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-security] OpenVAS based vulnerability scan for IEC 62443-4-2
 SVV-3 testing
To: cip-security@lists.cip-project.org, cip-dev@lists.cip-project.org
References: <TYCPR01MB8819714C4D4861EEBA44FD61D7B12@TYCPR01MB8819.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TYCPR01MB8819714C4D4861EEBA44FD61D7B12@TYCPR01MB8819.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: FR4P281CA0255.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8131:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a5bd629-f504-49d8-49e0-08df0d96bf3c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|4022899009|3122999038|376014|23010399003|1800799024|6133799003|13003099007|18002099003|55112099003|22082099003|56012099006|11063799006|8096899003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	m8La7y6L/qKJXIRX9i4bhgUlh4M652+3TEQgauFp3OCjH3UGLTBP4Jy7WQ+RgDmcfE2zzpXmIqj9QhLQ1vQJgTLqkVbG2+262HAwwzvZ1YTydCZcu4gEP0Ku/vPnm8auEeizLkkOeEZ1EsF4mvmESMXH6QY3s3VszcSXID9c/sV5Cs/5GEXmnCn8+kN3wVNbq//yBnkO8a+v0O1panodPeNWcsuDaLpFXBlhM0CGv2R0ao1YkELmUOfrzGI0cxq4Ooxyc2trPTlsvEzfcJfAeoBAzGfLmeKer/OoW8fkmBY9zcNinwsH2JWsexsbywVALBopaxf5A/9g2URng3PY23jhwbXq18r0h0bFFislS81AuEH1KbAV7p6OfBQLrsYJig3GAK1x5FsoOzxROZJlTgnCASAuEpuqX45wqxhz4a8uFeQAWk39C4QzM0R5SDYdkLIOUhx2sBv4i9LlwRMN7WSTcYkjVoM5naYQK6YfEh9dVT+GedpgvLTThQ7FOnUtOp5JKwZL7xLA38brY2BhSa3c4gHH0OZAaaomefu0sjJtsTINOzz2znW9ehPvMPpCTiz7OSkNoTmiT1lG0rnj3HHw9M2XQneACaCYZIR7rbo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(4022899009)(3122999038)(376014)(23010399003)(1800799024)(6133799003)(13003099007)(18002099003)(55112099003)(22082099003)(56012099006)(11063799006)(8096899003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MXgycGhLUm1oaHAydUgxV0ZNcmxXTUtMM2x6SmI3aXJoMCt5STdqQWV0RHRL?=
 =?utf-8?B?WGR2Z1JmS2ZreFMydGcrWnE1SFoxR0NrcDdjTENNUDR3bzJQOHNLTVV3SWlZ?=
 =?utf-8?B?dWtsOHQvU2Y0R3I1Z2Z2R0sxeERQUEhZRVltNU12LzJqWFpFaFRWb3h4b1U3?=
 =?utf-8?B?NlVMUGxDQ1Fab2FIcDFQVXoxRk90RjFsMHh6a1lTcmoybVhBYlNJVTZkQUpx?=
 =?utf-8?B?Y24zZ05ZaWZ6ZWtZVzJnWDVrMUo5Wkp6UlE3N3k1RmxoMlliZ1NwOWRVVlk0?=
 =?utf-8?B?TWczaFkyb2ZlQlNkZzdUVDVudHJsa2RQbE9mTmNBelNSYndyVCswMUhDNjhm?=
 =?utf-8?B?NVN1Rm9nMjhONUdSUmlOTk1JR0pSYUdSeUFLQXRpMExlNi9FS1hqYjJUT3VF?=
 =?utf-8?B?RnRRODh6bHRrV0cwajFDNUpMREtVOTZDVU5JSVhmZGtGSjFKcHVzRHVDcEY0?=
 =?utf-8?B?QWJJUDNUR2h0aCszR2czVjA0bFNaRVpNM01QWCs4V0NuTGtYRG9jZUJBNUdE?=
 =?utf-8?B?RzlucEVQcWhVQ0l5aDhhZmhaNDlKbDJ2TGF3RjdLazNjczVtZWQ4bUJSbWhH?=
 =?utf-8?B?NjhUSll6bTRodDRGY2pPRkZzeFZnUFJHWElGUkJmOFhYRGtBRXpQdmJhZ0hX?=
 =?utf-8?B?U09wNDBwWFI0WVhwaklzbzgwRkxXTmsrWkpaVkNYRUk2amNpVlpOaVhBWDFm?=
 =?utf-8?B?QktGY1BlckZ6dGYrUTFPYUNORzZJaU16QmxYQWlibWIyMnFKcDU5NTVFNjQr?=
 =?utf-8?B?aG5KV2pkZnlJbEVENXNlTndsK0NIWWpQUUE1Z1V6bTdwLzdaZnFCcEVoOEkv?=
 =?utf-8?B?SFRFZ095Ymk5NXcvVHRUSU11SkZiRmwyN1FUV2gwNzg3VW53WGFGbHRYWFFK?=
 =?utf-8?B?RmNmbVhBMWhMeHFqekdaNDRwVTluUUtaM051dUlGTlQya1dwaTdNSS8vZjUr?=
 =?utf-8?B?Y1kvVDNEV25ZRVoyQUtIU1d2Q01XQTBrNEc4Q2VvWUZyQWJFL0x2L09VTGVV?=
 =?utf-8?B?eWZ4cHBxQjNLaEIwYS9nQkNqNUM2VVllYkdCSUUvNmpRZjNMemhSSmpMQnFx?=
 =?utf-8?B?RkE1aWRWSVUydDd6NThqUEYvaXo2WE55SEI5NzdCdGZqejdDUCtLeWwrY3JX?=
 =?utf-8?B?TC9xWFJ5d3lUdU03Mmo3UDl4a1RkQnU0ZnYxM1JETUF5YWhnU0Y2T1Y5aUhi?=
 =?utf-8?B?Tk41TEpwM0JiRVAxOWd5Mi9lbnJGV3BYcU10R3VKVFVjQjNaQmM4TXNIWnpG?=
 =?utf-8?B?WFE5Zk90dUxzRHA4a2hqYXNtYUJQeGg3Yi91QVJHUVR1Q0J5N1BLNmwxbkdr?=
 =?utf-8?B?R21DMVRMb1Frc2UwTUNscnUvTGlqbmJCUVJQNWlLVzZiK05nVmtacHpZcUx0?=
 =?utf-8?B?a2ZsaFFLTDNnNFF0MzlrM3h5VnNrUGpicEd6YWQ0MThhc3k1U2dkVit4Z1JH?=
 =?utf-8?B?ditNM0xDdEI2L2FUcE1wRXIwaEh6b1IvUUFETi9mNnFOemF5RUVqNDVYaUoy?=
 =?utf-8?B?UXVwMkhpNlhGYnlrV1hlUDBmQm1XcU9sMnNhUzIyMlB0OHNFUjlpVmtrOGZ5?=
 =?utf-8?B?WGZDdVVUZy9xUmpKczgzMFN6Nmxnb1djcmJMUHJkSSszVmsyUDZKWE9rL3I4?=
 =?utf-8?B?NDI0RVQ4Q2RVZ2taMHJlZWhiUzFubGJrczRaSnlPWUZkak1iYXJpbnd6U1A1?=
 =?utf-8?B?aXNJSmVuZEpxRndReVBkTTFKVzhYYWRaWmNFcW9PTEZlbkJ3a2MzQkFzRjhq?=
 =?utf-8?B?TjhCSmZmaWtNQVJoVE5USDdYZkVrMnZ5RkdnMHZxQ3VlSnN4a0tIQzhhMEk1?=
 =?utf-8?B?RlhrdkU4SWtaVno2ajJWSTc0dWJJS0h5azR0SElseE96QmhsUndWVTVwaFJh?=
 =?utf-8?B?dStLUTRiS1pOOXZiM0Z6ZTU0MDF4cFYxNFI4L1V4Qy9sOFV1QjRNUXA2L1VR?=
 =?utf-8?B?RE9TOXFaRFZQYnNaMlR3T25YdWdURWxCQzZUZHo4OHJpNEo0ZUFyNEdpcWVP?=
 =?utf-8?B?SzRzZlU4WDMwa1VsU2JGeE1PTlV5eXhuUkE4bDg3UmxyS05ETGNESXJiMlpS?=
 =?utf-8?B?K1RNWFdyRFNWd0xjY2grQ1VrOHdsM2NuSGRvc3RQcjhLWWVzWnRlNHdGL0JJ?=
 =?utf-8?B?LzB0Tk9GRXVoc2lJcGRDMkgxdmRsSnVFUDJBdTM3Y1ZZK3MzYm5OOElwejFw?=
 =?utf-8?B?MTRaOHBzU0thTTRoeUVzR1BjLzgyemZwSmdtZUM4M0tWM1NQVnlYdDg0dm94?=
 =?utf-8?B?TzYzc3pKZlhEeW5pb0JKWXFqck1ldXQwNzJKQnZNdEp6RVV5NVBwajFVakwr?=
 =?utf-8?B?dFRrc1M4eFdFT2hPUEZnZUxud2RTWE5oMWVNUE5JTmpIVmtDemZOSThHNm1V?=
 =?utf-8?Q?q6eG9h0NIJu9Xa84=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5bd629-f504-49d8-49e0-08df0d96bf3c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:48:41.6508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eCF1iTeewYXkulJGrWWSQPapfqNonyVBPbLjFBtu/Z7EIYkqdTrwU3UV3+wyMRh9oBWnIq2XyI5iDYyPcqgSlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8131
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 08 Sep 2026 10:49:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24101

--------------UkWoJ8zSuPRM4qT2MdQHIXV9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks for sharing.

Do you plan additional measures to address even the uncritical findings?
And are there plans to run these scans as part of a CI pipeline,
highlighting news if there are any?

Jan

On 08.09.26 10:28, Adithya Balakumar via lists.cip-project.org wrote:
>
> Hi All,
>
>  
>
> As part of defining the IEC 62443-4-2 compliance maintenance process,
> the CIP Security WG investigated suitable tools to replicate the SVV-3
> testing conducted by the certification body (BV) during the IEC
> 62443-4-2 assessment.
>
>  
>
> One of the requirements under SVV-3 testing is related to black box
> vulnerability scanning. The certification body used Nessus[1] for the
> verification of this requirement, but Nessus is a licensed tool with
> no free version available. SWG chose to use OpenVAS for the same
> purpose [2] as it has a community edition available.
>
>  
>
> SWG ran a black box vulnerability scan using OpenVAS against a trixie
> based CIP security image built from isar-cip-core[3]. The generated
> scan report is attached in this mail for reference.
>
>  
>
> As isar-cip-core images are minimal, there aren't any significant
> findings from the scan. The findings are largely "Low" criticality and
> "Info" type findings which largely resembles the scan report from BV
> using Nessus.
>
>  
>
> [1] https://www.tenable.com/products/nessus
>
> [2] https://openvas.org/
>
> [3] https://gitlab.com/cip-project/cip-core/isar-cip-core
>
> Thanks and Regards,
>
> Adithya Balakumar
>
> _._,_._,_
> ------------------------------------------------------------------------
> Links:
>
> You receive all messages sent to this group.
>
> View/Reply Online (#2590)
> <https://lists.cip-project.org/g/cip-security/message/2590> | Reply to
> Group
> <mailto:cip-security@lists.cip-project.org?subject=Re:%20%5Bcip-security%5D%20OpenVAS%20based%20vulnerability%20scan%20for%20IEC%2062443-4-2%20SVV-3%20testing>
> | Reply to Sender
> <mailto:adithya.balakumar.f33@mail.toshiba?subject=Private:%20Re:%20%5Bcip-security%5D%20OpenVAS%20based%20vulnerability%20scan%20for%20IEC%2062443-4-2%20SVV-3%20testing>
> | Mute This Topic <https://lists.cip-project.org/mt/121141613/1050698>
> | New Topic <https://lists.cip-project.org/g/cip-security/post>
> Your Subscription
> <https://lists.cip-project.org/g/cip-security/editsub/1050698> |
> Contact Group Owner <mailto:cip-security+owner@lists.cip-project.org>
> | Unsubscribe
> <https://lists.cip-project.org/g/cip-security/leave/11905283/1050698/1444493412/xyzzy>
> [jan.kiszka@siemens.com]
>
> _._,_._,_

--------------UkWoJ8zSuPRM4qT2MdQHIXV9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Thanks for sharing.<br>
      <br>
      Do you plan additional measures to address even the uncritical
      findings?<br>
      And are there plans to run these scans as part of a CI pipeline,
      highlighting news if there are any?<br>
      <br>
      Jan<br>
      <br>
      On 08.09.26 10:28, Adithya Balakumar via lists.cip-project.org
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:TYCPR01MB8819714C4D4861EEBA44FD61D7B12@TYCPR01MB8819.jpnprd01.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered medium)">
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:Aptos;}@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}@font-face
	{font-family:"\@MS PGothic";}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:JA;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal"><span style="font-size:11.0pt">Hi All,<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt"><o:p>&nbsp;</o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt">As part of
            defining the IEC 62443-4-2 compliance maintenance process,
            the CIP Security WG investigated suitable tools to replicate
            the SVV-3 testing conducted by the certification body (BV)
            during the IEC 62443-4-2 assessment.<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt"><o:p>&nbsp;</o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt">One of the
            requirements under SVV-3 testing is related to black box
            vulnerability scanning. The certification body used
            Nessus[1] for the verification of this requirement, but
            Nessus is a licensed tool with no free version available.
            SWG chose to use OpenVAS for the same purpose [2] as it has
            a community edition available.<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt"><o:p>&nbsp;</o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt">SWG ran a
            black box vulnerability scan using OpenVAS against a trixie
            based CIP security image built from isar-cip-core[3]. The
            generated scan report is attached in this mail for
            reference.<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt"><o:p>&nbsp;</o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt">As
            isar-cip-core images are minimal, there aren't any
            significant findings from the scan. The findings are largely
            &quot;Low&quot; criticality and &quot;Info&quot; type findings which largely
            resembles the scan report from BV using Nessus.<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt"><o:p>&nbsp;</o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt">[1] <a href="https://www.tenable.com/products/nessus" moz-do-not-send="true" class="moz-txt-link-freetext">
              https://www.tenable.com/products/nessus</a><o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt">[2] <a href="https://openvas.org/" moz-do-not-send="true" class="moz-txt-link-freetext">
              https://openvas.org/</a><o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt">[3] <a href="https://gitlab.com/cip-project/cip-core/isar-cip-core" moz-do-not-send="true" class="moz-txt-link-freetext">
              https://gitlab.com/cip-project/cip-core/isar-cip-core</a><br>
            <br>
            Thanks and Regards,<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt">Adithya
            Balakumar<o:p></o:p></span></p>
      </div>
      <div width="1" style="color:white;clear:both">_._,_._,_</div>
      <hr>
      Links:
      <p> You receive all messages sent to this group. </p>
      <p>
        <a target="_blank" href="https://lists.cip-project.org/g/cip-security/message/2590" moz-do-not-send="true">View/Reply Online (#2590)</a> | <a target="_blank" href="mailto:cip-security@lists.cip-project.org?subject=Re:%20%5Bcip-security%5D%20OpenVAS%20based%20vulnerability%20scan%20for%20IEC%2062443-4-2%20SVV-3%20testing" moz-do-not-send="true">Reply to Group</a> | <a target="_blank" href="mailto:adithya.balakumar.f33@mail.toshiba?subject=Private:%20Re:%20%5Bcip-security%5D%20OpenVAS%20based%20vulnerability%20scan%20for%20IEC%2062443-4-2%20SVV-3%20testing" moz-do-not-send="true">Reply to Sender</a> | <a target="_blank" href="https://lists.cip-project.org/mt/121141613/1050698" moz-do-not-send="true">Mute This Topic</a>
        | <a href="https://lists.cip-project.org/g/cip-security/post" moz-do-not-send="true">New Topic</a>
        <br>
        <a href="https://lists.cip-project.org/g/cip-security/editsub/1050698" moz-do-not-send="true">Your Subscription</a> |
        <a href="mailto:cip-security+owner@lists.cip-project.org" moz-do-not-send="true">Contact Group Owner</a> |
        <a href="https://lists.cip-project.org/g/cip-security/leave/11905283/1050698/1444493412/xyzzy" moz-do-not-send="true">Unsubscribe</a>
        [<a class="moz-txt-link-abbreviated" href="mailto:jan.kiszka@siemens.com">jan.kiszka@siemens.com</a>]<br>
      </p>
      <div width="1" style="color:white;clear:both">_._,_._,_</div>
    </blockquote>
    <br>
  </body>
</html>

--------------UkWoJ8zSuPRM4qT2MdQHIXV9--

