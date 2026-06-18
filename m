Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70337CD98DE
	for <webhook@archiver.kernel.org>; Thu, 18 Jun 2026 05:09:21 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12761.1781759355517810890
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 22:09:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Vk2XhNMR;
 spf=pass (domain: siemens.com, ip: 52.101.70.56, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hN9vVafzSWejacPwzDJC15qOjINYDsoTvlNIDxcyElmUYGUUDfzYTq0kFaTnn/W0V16g9WnMe6RQBsA8YgwTDd0QoasSpsZ4KxxaJ5a4rXhs+CB3JvU+f35MC9wNvfAdfa6kfcGkVsG74fIV1we8fY6g+oSqc2M3tFwYnazVgnH2x/hUxrf370eYf1MkWL+yeDFxCUFiMsZgztuDmGXitcsWTBhguiZtpfpvH/s5+mEH6f5OHHunO+ZlqdvdaP0E8nzkAocuETrHMhtMWeO37GTbVwQpA0kY4XF37O0rYhanAB2FDJKYhf27Z/fR3tlGFIRKmQ8+Ptic9L/2m+cWQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rl1TQGFt0lY3wVb7AkBFAGAta/QD/toMmh24xtxPyLA=;
 b=sYTZD8UKFchw6ivEgwVyNgIWKkAbaHR5VbvVCBJIpyRw7SGy+6YjL9g97utPPp0joVQ9F/7TvNc5N4kmYQsSmrHhdti58g0Lcmp1Q7w6Hv+9HTYHyPQKlICmM//C21c/tzJgHuhkJ7HFh/ilQrmJOanE1LgabeeidVCosxcV/uOrDgWz/X7zzB5VpCyKFvMz1dn4Ap8KP4FqGCJWEh3KWrOSipNnrDptRpL+lgnRbefFkdRMePC8ADDzlKwigwlGuHLCMUA6NKx6yXPn0gHRWKyqHaiL4C/xlOOoZVSzfS5K12gMPvfnUikoua4L0vEcoaPt7xpXiBWAXjzKwHc7oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rl1TQGFt0lY3wVb7AkBFAGAta/QD/toMmh24xtxPyLA=;
 b=Vk2XhNMRWZkiuRU2vmdhMim8bx5WMgYTaKoOlSNMnHKShGT5g5wX+5L+Cwij+r2j6JSDzatW5oGv73owE76RNpEfucUJcr+i93q/+kQYJMZcrSvhENzfnr57a+4fWCHW1AcY3nPMhZqu2W7gYXPfZpUeAP8ZbCdXOkVifoKmTnYba+4LwFiYh90SuagVCaTH8wj4SWeVzLDeeqyjzAKmj3zKS9FEI5nutrlPfjmULn/a5mZ+m7a+Cys8ODeB8YNk5ixkbusj6t8XhS/xdmPDxkWKi1FTomst5Si+V6YTv7K3HivZF4joKCOjyU7GmT4hhPajReIxRb8dX19jAlxO0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8921.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Thu, 18 Jun
 2026 05:09:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 05:09:11 +0000
Message-ID: <32e2d89f-352f-403b-be31-79eb3331d14a@siemens.com>
Date: Thu, 18 Jun 2026 07:09:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 2/2] Add crypt library packages for
 Debian sid version
To: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: Adithya.Balakumar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp
References: <20260616050628.3560536-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <20260616050628.3560536-3-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260616050628.3560536-3-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8921:EE_
X-MS-Office365-Filtering-Correlation-Id: 43286143-f4ca-46d3-4f72-08deccf7bbcc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|55112099003|22082099003|18002099003|11063799006|56012099006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: 
	XY7HlgxO5TaszbDuSVZk1+ICaI150AfahhjJ5P7NP0db8UASDJvpG3x0kRXuKbZVBPwaFuID0BRiWX/KDk+CMCjzEx1McnZBWMr8WgobcuieQqq/tkDknGjy0rEvhGED1cfYVFQx2S4iNFqT5OhgxltkIegkubMSoq2bAYZ4AwfQidS7kYf05hjAX8aoIzE5At0GdF/zKZEOMLxLc4oL4wQ0ndZY8jl6kl4npJl8ev3BwHAqRjsxpo+smlVev8aU9E5MWQk7DmHX71h8EXTBKq6NwxX/xSfIbeBD0YNBBGQ6bzqMMYik546beO9axGgoQv6Cz3XHmlUE4QxQXlPmNgLvV60w0sRf+Ti3BCV5SAok/Q1FA/Fa5xu9/HqIJwlmCZJSRJ9QouulCmX8FJJo+uJg3pZctqUhqLsehif+L7Eg5rYVjmv5VnRAZ5wv+TSHfIROJsRzZPkVyC3z58HuIymnv6JCMgz1CDECz9zjgJymtvUFACKx6oVCntz9x8SgS+U+4M09Lvx3uPCF9ERrDIDwFEUswZ4hk2yiOfWbNjlXlrP1/FjsyZkRyx9sNtJ63XKQg88xgTG6CFi7NaxomAWYFoFayYqozijUqRZPuzdIKSSL8iUvD9YpcXby6Bf5OXZp1QTKSt3FtyWg+iW7K8UBUksEv3tZzGRFEj+wMzkiR7tH9PcXo8b+UPcbiTSv
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(55112099003)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UWtUVVovSzQ4a1Uvci9sWW04ZWpFUExNckpIa0xsTWxzYWZ0a1RheWtLYUhF?=
 =?utf-8?B?U28wNGxnMVNzR2hLZEZhRXU0VjB5Y2FCUUZnRGo4bFpoTkdvd09DRjBFQ1Ns?=
 =?utf-8?B?OWc5ZmdLWUNsVFlOY01EM08rRkdoME81SDUydW5ONHREOW9rTXRldkRFcFJF?=
 =?utf-8?B?eE5lM05XTWtXRmY4T1RBL0pEaTRBc0FwUG1wNG1VWGVuNjZSYTFscnExTU1o?=
 =?utf-8?B?eFRPZ09FTlVDUWZJckVjaTNxUlh1cUJpTG05d1VQcnF1dHBlVFUrRVlLY0Zz?=
 =?utf-8?B?blVNeFNTVDJFbkc1THFlSDg4VnlNdW5DUktDVWxQUzBMVnlEUEFsSnlkNGVs?=
 =?utf-8?B?MjlGemxkMUYrTnNiblByN2FLR20xOHZGTmY1ZjVzMmJJTW41SGcvK1I0dkEy?=
 =?utf-8?B?TzJ0QWdBNE1nR0dEdVI0RWZXR002Q0puRTVISlpBcUlodEkxWnRucytROWpQ?=
 =?utf-8?B?NHJWNVpZMjRDYTZPOW9iamVPQm1sTlQ0a3VSa1BtRHZlZ09xd3pjNXRpZnBy?=
 =?utf-8?B?c09SZ29PWXM5SFpWeWV1b0NjaTNsRTBLNzdVb1M5Rjg5QjhELzVkL2FvcDZN?=
 =?utf-8?B?M1djc0l2VzNsc3FjODdjWStQL1JkQ3ZkcWx4Y2o1K1RGenBiSFIrUC9OVFJk?=
 =?utf-8?B?YitKMlN2dEhyZHBMbWFNbFlRZUdreFlPMXBaR3U0RDBGSW1hd2svVG12eXRh?=
 =?utf-8?B?d3pOQXNqemZhUjFGbFkzc2lhUy9DTjhVTm1UMXFrSGZ5VzcybnAxcHYxS2hi?=
 =?utf-8?B?SlFHekpQMWRhQ2RBTjJLcENjUGZGbGs4T3ZycjBBMUtrelNuUXRxN2hvVzFI?=
 =?utf-8?B?SU9meDlDbm5sN1lUWDNXM3pWYkJzUnhZNFpMN1F3OVpwaVZOM1VpQ2wxMnRQ?=
 =?utf-8?B?S2VpaUJIL3hrR0xTYzZETGpjYkhVSWhCTGIyMDA2Rks0V0RTK3hpWjZQZkRx?=
 =?utf-8?B?dkxxcFRTQ0I4Z1hoQUdabzY1WmlzWmxMeHpjMnNEcU1aYlNOV2hWck1iTm55?=
 =?utf-8?B?eVZUUjRlN0VnSFFYL2I5VjIwUkIvM29mSllYM3JZdDBsL2JwZjBPUnlTL29w?=
 =?utf-8?B?ZFdzK1Z0ZlpGckt1M2k1V2pVNVZaRXVWSk9mMEdHVE9lamhkcG9JQ1VncWFi?=
 =?utf-8?B?TENhLzRIa01Vd200STltbmdzbGtKMkd2STRZMkRnVUZaVTRnMGh0TEFFcmNn?=
 =?utf-8?B?VWNwNkRMelN6UGZ3M0FpQ3FLWXdlcVkyYUdKanlVb0xOYjZESndoTCtpN3lw?=
 =?utf-8?B?alVKUlJCK0xxQ0NLcXZZUFhOQldCNWMwVTBWN3FiZVpwbURUUVlTU2tMOEkx?=
 =?utf-8?B?aE96RVMzN1pvWHp1MnBpUURwaGVja2UyWFVuaUoyMlZzTGpYTFlTbDZjMXJK?=
 =?utf-8?B?ZFJXWExvNXNzSTZxcXY4TW9yWjNhd1BQSFJOcTQzT2hMbnRxYndiNHZBcjdt?=
 =?utf-8?B?S245TTJ4dGl3Y0V3OGJyOU9qQXJTZ2lrdzd5c09Qd2hTUU5DSVBnN1BqMTFX?=
 =?utf-8?B?cy9hditieVFPcDRJTWRQajlmbnFvb0JyNllVUERRUGl3MUM0Y1FGNVRlRmxk?=
 =?utf-8?B?RXdIVDFubktpUTVIMFUwNi9jOFVNa0xYUzJybzRuT2NCOVp1ZUNSTXI0aW4w?=
 =?utf-8?B?eXkva0VSeE9ieGZtM0R6ZXJ6SjdjZDZJTm9IZzlpak0zM25Zc3lTVWVtR1JX?=
 =?utf-8?B?ODB6ODhkNUJnL2w0d0hmOVBaS0RmWU5HMUp5Q1RQRmdNeWxmQU1vM1pvUC9s?=
 =?utf-8?B?RnpBNllKaVpjaE9CdVVOWFBEZHVHTmxabXQ2bjRUekU3Q2ZjWTdRQjVyM3VK?=
 =?utf-8?B?dTYyaUlwdXdKWTkwZ3lySUx5YVA2YzEwT3dZR1B4azFSUU10eUVCTUZVVUdZ?=
 =?utf-8?B?WEVleDZaSHZlbmxLbHkrU1VsMzI5SitCSW5RQmRnc2pQUFIwZDFvZlIwcWpn?=
 =?utf-8?B?SnVSTHA1RHV3NHJmZGowY0IwSW1Lc1pMYStyM0ZpNFFhMlhZbGZZTkZ5S1ly?=
 =?utf-8?B?a1pqMFJGSjlZQTdPVFM5VzlpYjJWdUVLb0xwbXZrT1NMcmVUUHVpLy9XR1lJ?=
 =?utf-8?B?SkNKaXQyanBTTGRxcjlKdlprUGI0ajRwQVhxdE5xOEw5QWIyMytxWlJ1dldk?=
 =?utf-8?B?WXpEVERyUEJtNjV0RDVvZ0FLSnd6dHRKMkdpNEp6V3lMY2h5ank5VHowTEhH?=
 =?utf-8?B?VVA2VGVXODUvL3QvNXRiT1dSQXVnUFJ1eGhyRzMrOW42VzRILzdGeWhCRWk1?=
 =?utf-8?B?ejlFNHJ1b1VTS3lDKzBXNEt4dFpnOTBUa1FPa01KN3EwRi9XMC9pNmQvdWFz?=
 =?utf-8?B?ZzMzR0dSdytKQ1FnWmxuY1BzU2ZnaHYxckR1TnhVTFd3T0pFd2F4dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43286143-f4ca-46d3-4f72-08deccf7bbcc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 05:09:11.4010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qB4nEMYBIgIP6Yw/H7m704LJ9JV4nkKSDgWa4c4/08bMtFhhltqHBsPGPbThJPTEd3DrRiOUOeroRswXGkaVmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8921
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jun 2026 05:09:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23221

On 16.06.26 07:06, Shivanand Kunijadar wrote:
> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>  .../initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb           | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
> index 3cb0520..2c3c331 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
> @@ -38,9 +38,11 @@ DEBIAN_DEPENDS:append:buster = ", libgcc-7-dev, libtss2-esys0"
>  DEBIAN_DEPENDS:append:bullseye = ", libtss2-esys-3.0.2-0, libtss2-rc0, libtss2-mu0"
>  DEBIAN_DEPENDS:append:bookworm = ", libtss2-esys-3.0.2-0, libtss2-rc0, libtss2-mu0"
>  DEBIAN_DEPENDS:append:trixie = ", libtss2-esys-3.0.2-0t64, libtss2-rc0t64, libtss2-mu-4.0.1-0t64"
> +DEBIAN_DEPENDS:append:sid = ", libtss2-esys-3.0.2-0t64, libtss2-rc0t64, libtss2-mu-4.0.1-0t64"
>  

Please align indention here so that it is easier to see that package
lists are identical between trixie and sid (right now).

Jan

>  DEBIAN_DEPENDS:append:clevis = ", clevis-luks, jose, bash, luksmeta, file, libpwquality-tools, clevis-tpm2"
>  DEBIAN_DEPENDS:append:systemd:trixie = ", systemd-cryptsetup"
> +DEBIAN_DEPENDS:append:systemd:sid = ", systemd-cryptsetup"
>  DEBIAN_DEPENDS:append:systemd = ", systemd (>= 251)"
>  
>  HOOK_ADD_MODULES = " \


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

