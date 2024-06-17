Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD0DC27C79
	for <webhook@archiver.kernel.org>; Mon, 17 Jun 2024 10:05:54 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.85])
 by mx.groups.io with SMTP id smtpd.web10.53246.1718618740362775371
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Jun 2024 03:05:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Bq3QIIok;
 spf=pass (domain: siemens.com, ip: 40.107.8.85, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=daUikyLjm7Ldu449LOvQDBeb7h24Y45iE5G6tJPoFyZb24XU2B6EJmLrJu9C9Fz1k3zWh24Z2abMTbdB83Gerw1VxN7OjavbxBhPgjdgvOHq5b4WzJRQhUp9TYAkn4+3Ju8XHOe9tsR6e6g2jevf9B/lZw9lF3ykDQRuZYB5J2M/XoAeG6ZIIpH7sniStn0AUZb/Yzh1CzRfuwRDafQ1kGxI7VokE8oU6RJbSyRWGFs83tK+inHEOnuoJlgrzecdNH8WIajurwCPsM8uzd3xfkr4XG0fRW0r3bO0XRjVV9qpHMan+Mg8ymoeb9bYeT6+4A+3sc8jFgJ4+ySaqkRWmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYGX69bbidMK4Sik85es32c1qOsHwFnOK/MHjl1JBsY=;
 b=WVn70LwZVyvwYpHGwDOSHojQ6WaUvCBPQtv/poOKAbeZlWBFXfwGfNtd23SlTw/9CRk9H8zAla8XaMcfTheP9XOQIs7PKYialtLF0AMtK/phtU/lsh/OXnsS7L81nFfPQx9NXT7Wimi3TPHpeltIm4uEYzW0lh/UllTVD15Yo3qVB7p+2wZ0tZ210EtiSigxaNrppTnbwO7RXpeSZCs0Yu4NUI0tvNznSruZFkJlKLvXYjRNhZp5rAtjsGQT3C9lsf3l6fwFq2Hp0A6vGhABrKcjj/ASkKMaPkUibIAd5G+6NJm8+oBFyoCUk6gNmu9kCEwqHaAuiaPUh1zHWWSkhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYGX69bbidMK4Sik85es32c1qOsHwFnOK/MHjl1JBsY=;
 b=Bq3QIIokrCyR7Am+mWLkVKYgotEsIBr0hCZt1LgQFxfVta5gBAc1YZa8itnVNPSEGjfz/aQwa240KAe1rfnyuE/YhS0GZNJ/ecWkg9H7j2az0qxjb4t1ZuFwaJcf5tWFlBhM3RfTmHoUmQAEWMCxBswgUKwd4Ti5CizlAXe5JcMzTP6q5+LB75mqXYM0txkGQsHf78RD3LpweRoUSyhW0FtnGVtuwqKHIZDhed/5/wBR+jnx20KKJTU7znNqPQX/Q0Ya4v/C3MekP2no9C1lANG4ZsrnWdKh+h5tQAy5EGJvR13mV0k3+Qdxn1w7b+Pl1TkYQA2qCz2gjaQ2wUrTYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 10:05:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 10:05:37 +0000
Message-ID: <bdb4ea31-3d19-4600-974e-8795c9b80ed1@siemens.com>
Date: Mon, 17 Jun 2024 12:05:33 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Bump Isar revision
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0306.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3172:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d1e64a-57d4-4c7e-49f1-08dc8eb508f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Ukx3TzRja254ZWFSZ2s5ZS9Bb0JrdWpHbFlGdGZ5VmZ1aWJoeU41UG51cU1h?=
 =?utf-8?B?TWV0SmNpUXpkdTdPcHBDVURrRFJOUUNRSkRCOThQUmJBaWs1R0NodXpKOVJu?=
 =?utf-8?B?M3BhRUVidjZqTmFvTzBQVGw1TEVadEtweHJmSm9lMGdLTjY5bGhWZlR3aEh4?=
 =?utf-8?B?WlczUEQ4ZzJEQzRSTDJYVGh6dHdwNWZnT3pYUTNZcUVBM3pQSG9kQTZyUmVy?=
 =?utf-8?B?VzdWZW5lVnA3TVhpTVFodEZKL2tzTVJvRkZ4ajlXRC9zVFRETTBmV1c1SWtz?=
 =?utf-8?B?bXRwa2wxSjhPMVZ1YVd4TnJJa2M5ZG9HYnkzMlJXd1hUb2xZdi9VYWtNTU80?=
 =?utf-8?B?aCtIVnMzM1ZVYlVTcHBtakRrb2xFUURHZjNSWmN6eWdIUklqRkVybENXMWVz?=
 =?utf-8?B?TjJpbzl1dkhLNFhtUmRjTGgvNWd6ZmFMRXJBS2xONUFjTk81QTZNbU9SQ2R1?=
 =?utf-8?B?dlNuWUFCcGkxUzhCbkQvc2JsYnNxZ3BrMUx2bUNMY0twQnJGallHaHk4Y2VJ?=
 =?utf-8?B?YVAxWnQrdHRIVzdVTnhhRzZ4WmJsRDZKMnl4M2Vqd0lieFE0VER4NGlGeFdp?=
 =?utf-8?B?ZVJCVzVPSzN1WGFCTDc5MlMwYWZwZTZlYStMOHAyaWVmTHl5Yi9EdDY5elg4?=
 =?utf-8?B?ZjVsRnJJdGM2QjM3Y3d0cWt2UHFsTUpxa1crRnpxREhvbGNHY1daL1ZkSnNh?=
 =?utf-8?B?ci9GTERsd0dmcWZOY0NqczFuYUJRRjBUb0NlSzJhN1NVakwzbHF6em9LWUNQ?=
 =?utf-8?B?TXdVYVNQZWtDUHhNbEhhY2cyOEkrMDdPY3V0a0FaV3F3TFJmY0UxUjRGQ1BY?=
 =?utf-8?B?SzVjZ1A4Q1p3ckFXZDdLdXJIS2s3TE5PeGR3RHRmMmMrN3pVSEkvR3JPUXRa?=
 =?utf-8?B?Z2kwalczUVlXWk5rbjJBMFNCMEVKZEFTdDlQTmZWTnlQVWQ4SW43K0VIVjNj?=
 =?utf-8?B?cnQzajdlU0lXTi9VSitHcy8vVHZEOXJNNVpoSU1kS0lWMXdabDFtYWdrNkRi?=
 =?utf-8?B?bkZmbloxcmpDSjB0bFY1TmQwMWp2T1k2Ly9rb3Q4c29wOGFxdWlzUUhEa3Z5?=
 =?utf-8?B?THlaQTFVM0lCNlhkbEs2SW03eVZkbXdvM2N3QkdoTXBWaE9RdHZjTVlZK2d3?=
 =?utf-8?B?S1pydDcxZXpSdmhCbHdMcUVJZ0tic2RZOWx6RlFpTmo4eG5YNUo5T09XVC82?=
 =?utf-8?B?b2tobHZCNllMS3lmS3F4Y3NiRzI4WmEwMDQ1bkdNb0U4Vy9HemN2Nlo0Z0N0?=
 =?utf-8?B?eldXS2hmUEsrZklPdjJPclpwZlhCcFlTK1pWVDdYMXFTR0tsc2JpeUpDQlpM?=
 =?utf-8?B?VHRtaHlyUjMwZFR0K2h3MllhRlY4eW5wcjMyNW1MbWJURlhZT0MxQ1ZGMzFv?=
 =?utf-8?B?QitoTGhCcnRMSEhkZ2xuWVYrQU4wS3hRZ1VUR05vc01UZ3ZKTVllSnBjYjJr?=
 =?utf-8?B?S29FazFWbG10V2s0Y2QrRGd6RVlNTE82N291WjJDeVE3MVo5K2hZa2RET0s0?=
 =?utf-8?B?UHJJcTBtTlZkbXRuUlcwS2FQdWdpUFNrZUNrczdGcUNNYk43MXQxeEhadnhn?=
 =?utf-8?B?YkJIRmpodnhrWFZpR2NhRE5NK09xR0tRaG83VnRDQXltbUpZYmlZeVEzZi9F?=
 =?utf-8?B?UUZoWjBBT2RQTGxHUTE0RW0wTndGRHNEL2hUL096dDFIaWNUMVJYSGRVSEc0?=
 =?utf-8?Q?gddWrtlZb+lp4IIGgiSm?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZlYweHUySkVybXZWM1FIbGx4VzdDVTIwTHVGb3k2K3RWaFA5bk03VkF6cVdX?=
 =?utf-8?B?WFdtazhucVBzVm9rd240N3NlVVNNVk5vbEMvSER5a2ZFSkZJQVpmUlV3c1VB?=
 =?utf-8?B?Wmd6NjZFd3hnRElzcHQ1UFhSVFhDOUJJWUhManpoMmFuTXVkMDNuNVpLUGJz?=
 =?utf-8?B?YWJGMGZBaEZCRXg3bkdQcFlUUVh4UEwzL1Q1bzJUK3MvMm1vNmR1b3dFcFZP?=
 =?utf-8?B?VHQ0dmsxWFJaZWFtUVhGUTlMOHU4aVNZUTdLbTdhbExEY1NEMGxNcHppdFNU?=
 =?utf-8?B?V1BOMkl5bVhJbkpYNjlSeE1meFlOQXpWNHhWTXgwZkUwcW5Kd000aFozcFpQ?=
 =?utf-8?B?Ty9ocGR6ZVVlektmUUlpS0hKMEhhNDQySlJWNm1VdGUrQnFWNXJyUEUxaVZG?=
 =?utf-8?B?V2ZpZVcrV0FMTnNKYXdqUWF0dWJHRmFBMUtIbVk5eUVhanNaNVNYcHBXd21I?=
 =?utf-8?B?TDlmN3ExV0JMWHZwcms3bGxlSnBZOWVzdzV4cytvYkJXMG15WmlNTXo5RUh3?=
 =?utf-8?B?MmI5ZGtvL3lMd2NYVVpMNENGNkRrQVdNYWJNMnRWVzhwYVp4UFdJWmNNVnlu?=
 =?utf-8?B?eGlvWkJHVHlWWjFxQU53b2dSRzZoNTBZWVllR1F6ZFVjRWNnQm4rZEkxeG9l?=
 =?utf-8?B?SFE3c1JkbGdYalV5d3A3TUFJUi9qWk1yWmQ3dVpyVko0KzRRRlBpa3drTU9G?=
 =?utf-8?B?Q2toOHlpbnh5dzNURGt4cHljYXZ4ejBQSDllajYvem9RY1M2MTlHdHQrbUhH?=
 =?utf-8?B?a203VDhlWU11UkhFZkRlbUhVcW01bmliVzJuc1ZVMTBMdlE5bmtCUjZVMXRM?=
 =?utf-8?B?QWtrSWN4c1JDVGtycGp2SGZOR2oxUlBMcWxiWjFsRVpxek4vWVVFV3VBTU52?=
 =?utf-8?B?L0xlcEE1OWNRY0xPMUo5K0hWclZNbURaYm1weEJ4dWZDZHJtVy9SMXZRSUhG?=
 =?utf-8?B?NDJ1eGI0d0Z0bmh4QWRkMU1DeXNUenBKY1dqMEt6UHRtUEw5elhybmlKWnJj?=
 =?utf-8?B?ZllDdlRHR3ZQdXI5dERNWjdrZXpuYXJVbWx2bjd5UUhsRk9QM0p4VnFBblc1?=
 =?utf-8?B?Y1RuOVc2Q3h4cHd6NkphN1NqM0tGY2FBOGE3VGMzT1hnN2xPcXFvY3FrT2N0?=
 =?utf-8?B?ZFZiUUJITXBTRHpadGx6a0U1Rzg3WmdOelkwdEYreGxUUEluanZKVjYrSzhR?=
 =?utf-8?B?Q04weXdqeXdFSExOR1FYRE4wYjR1Vmk5NFFkM1lneWNCblI3YlJIK3lLYUJ5?=
 =?utf-8?B?dnRhQXpOTHdYZHNRVUZMSHVsK1h6ODRxMUFnNzRMdDFqbndjd3FRWW9vOGpO?=
 =?utf-8?B?eXpmMVMxeW5kRXpJZS92MmtNMVNGeGpzV3o4Y0VReWpEYjRVRU94UERkSG9a?=
 =?utf-8?B?K05IL1h3TkhMaFpKRDZVVVJITHJlSnBRU2hSdlY4THNDbnd6cXB6T05BVkhU?=
 =?utf-8?B?RVkyalJRM2xGc1pkeDBFeGxmSGlOcmhIU0RzNyt6YXMxRjh6WjEydFVXTnh0?=
 =?utf-8?B?cUR3UGxPQWhQdHNlZ0Ztdys4MlhUa21WV2Zxelc3S1ZxWHZaMkdSclk3eFV6?=
 =?utf-8?B?VThuYzNwV0ZvYUQyOHZFdjFQbmZKTnZEeCticFhucS92T2FZcGZGS1Jwemxx?=
 =?utf-8?B?b2IwRXRoZm5jNGw2ZUlGdVpmczFuWXBlMFlnWkpkNDFHaHNvdmNqQVp4OWtr?=
 =?utf-8?B?WS82Ry9tNUNaRUw5RDRicnVpMnZ3YWJZZUNqQklyaitlZWJMcS9EeVdmTm5n?=
 =?utf-8?B?TC8zYVZmWmxRTFZFNHZvdmtGS0JXOWNsbFJZQUZIaEJ4U2VNRjlNUm9mRlFJ?=
 =?utf-8?B?c0hCc0xVYTlHanhUR1k4cFBObDkvVDJoa3YxNi9Qa05DTFFocFg0UDc5OFpF?=
 =?utf-8?B?NWhlamFmODFzS0pUempZSGNQb2QzaERrcEp2WklWOGtmMVBKN3o3eG9hQmty?=
 =?utf-8?B?VWFWV1p3bTBIbjVlcGs5Vmp1dkFzMVB6RE5ON25TWFFtdWQvbzZVSHJFRnd0?=
 =?utf-8?B?UUUxMmtHaUhGdkd5SWtwMDV6b2ovR1lieldxSjdsRjJ2N2xPUUFlcTN1ZFNl?=
 =?utf-8?B?bEJ3SXNQOWFUWGpVdGlPcDR2RHRVOEZsYnlpeE1DR0xkOUMyaTNxQ2k2NHRm?=
 =?utf-8?B?V1hScUhYZHowcWcwOXdOV0Vwa0xhTGlCNk1rVU1oekVpMzJrUWM5Mmd5U045?=
 =?utf-8?B?WVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d1e64a-57d4-4c7e-49f1-08dc8eb508f8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 10:05:37.2286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRF7Jy6xyhfEGlklUYKMpUHXElyrQB3Xw1OnfEEBPMklPR22IXke4yHq9COfKXmHUz9LBfSlKEZqVsZB6XTwrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3172
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Jun 2024 10:05:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16259

From: Jan Kiszka <jan.kiszka@siemens.com>

This a fix for a regression of the isar-init-build-env script but also
also some other smaller fixes and improvement we should adopt for the
release.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas-cip.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index 9e49366c..f00ad74c 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: da3804874dfdf825b9053d56a1e441ff21d4417b
+    commit: d2d3b3e94874d62d48c0cafb99dfffde6afbc6ce
     layers:
       meta:
 
-- 
2.43.0

