Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AE8CA0EEB
	for <webhook@archiver.kernel.org>; Tue, 19 Aug 2025 13:09:23 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.29])
 by mx.groups.io with SMTP id smtpd.web11.13794.1755608962130896207
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Aug 2025 06:09:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=O4IoA8Ll;
 spf=pass (domain: renesas.com, ip: 40.107.74.29, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wE4oyeZ+45v1x1VbF5wXspUml1RzfpxCGih/iNoV//zhcADpZaTxN44wOVitRJ4qSoRNNG42a6ipfW8ZZExvVlWC2xn2EYp+XQeCl4I70Mr4gJyJZPcWe2dj0Uxy9g1zGBn2b871qMB0QI/9AUtdEccSGcV81w9vEBvSNhXJxQgmeZo275A/RQwH7N2YOBhcNkxlLQMHeZkpYY42l6QBfafFrsQosvDtoS9fZ+qzbpBn87JrWH6pGJa1FXm7D/f7licHd9k/nxF/DZF4VYtWOcHlfYE2upGGkm7YbGYRtlarVn1mKE75hTAsxgjd22cIcydWCfmf1rtM/f1nd4pTFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G52Rk677flv2O8Zzvgb72rBiGpEpn3w4/RxBTj7wlmQ=;
 b=B4rLBHuo7WANQ/GZcnpl7Ge6XfdImWdCVuwoW6ksYP2jhQn/49EbM/5J/H5vu1PfZa74Fy5eOXx3Rbq0voWnbgSY3pkaBcip5HAAlp5FORcuG0stuaAt0I8NZuLjAaHvfnBS3lMxKuGvOnQ2cMlMbRyH2k3TwEPk2Ialhq5vBEkDM4FmpMfRKKBe/L9azyCALDEwa+46N5CwpbI2XyPYBSUoZy9pU9Zc9LZqOm7Zl6sQm1gxHhTk9DA5edN55EePwlzcxfm+MZkoANfnFkVw6Q7rdDJdJJnBo0qg1KZGgEiYYPL7eFzYDGPdX6OeyXHyyBmoXuw9RUt9s/VYwcdb4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G52Rk677flv2O8Zzvgb72rBiGpEpn3w4/RxBTj7wlmQ=;
 b=O4IoA8LlkPixQBR4P6zk+lNVnQBBfJsiydpfJi7eKAhrwwPH8LYu9iOg7YJDE+W8kliCBDkY/mvDRN/CL9Jmb3DTUBkOItwESFpM1jKy5diaRw2QkAHWfN6lCCrVW8wkHg4RsWCuGeFiRJSRP3jj3bZZGkBG0RSLTXMfPL16f3w=
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 (2603:1096:405:1a1::10) by TY3PR01MB11789.jpnprd01.prod.outlook.com
 (2603:1096:400:406::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 13:09:18 +0000
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6]) by TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6%7]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 13:09:18 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "Shivanand.Kunijadar@toshiba-tsip.com"
	<Shivanand.Kunijadar@toshiba-tsip.com>, Quirin Gylstorff
	<quirin.gylstorff@siemens.com>, "nobuhiro.iwamatsu.x90@mail.toshiba"
	<nobuhiro.iwamatsu.x90@mail.toshiba>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>
Subject: RE: Effective QEMU devices usage for testing in LAVA
Thread-Topic: Effective QEMU devices usage for testing in LAVA
Thread-Index: AdwNI0Zo7YnIbeRzQ4KMFrrfEXZpJAD5cXeQ
Date: Tue, 19 Aug 2025 13:09:18 +0000
Message-ID: 
 <TYYPR01MB151321574499D48D7E7119A7AB730A@TYYPR01MB15132.jpnprd01.prod.outlook.com>
References: 
 <TY3PR01MB11075A93846FA70A1AEB01145C735A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY3PR01MB11075A93846FA70A1AEB01145C735A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-Mentions: quirin.gylstorff@siemens.com,nobuhiro.iwamatsu.x90@mail.toshiba
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB15132:EE_|TY3PR01MB11789:EE_
x-ms-office365-filtering-correlation-id: c3daf781-b35c-4bd8-f126-08dddf219af0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700018|8096899003|13003099007;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?TVZqSFFtbUpiM3J6QndOVDlqUWpJYkdlbUEyQzc3T2xhdzVZQkloOXdZ?=
 =?iso-2022-jp?B?N0Q3UkNSRlZGUU10KzR2Um5ZTkk1djUwL0xVeGdZbDFLbWpuVU82N1FY?=
 =?iso-2022-jp?B?dWN4c3o0eDBnNWxBUnYxUk1XQ2lEb3ZRY0pUNWhRNUx1dWIvT1E1cWto?=
 =?iso-2022-jp?B?WS90d0pVWkJiaDJYSWtSVEUvclkzd3kxM0tZZUNWSGFwZ1JvR3k0Ykxp?=
 =?iso-2022-jp?B?S2kzK3JIaVRWckgwdkI4MkpaaUY2UXgzaGl4TVA4MVNYQTViSUVGT1VU?=
 =?iso-2022-jp?B?VXcvY2dVU3R2K2dEUmxPNVBrdjA0NjJqaExsRFNDWnNYUk5ycTRXQWM1?=
 =?iso-2022-jp?B?SDFPRERjV3pnQmhRTVR2dWthK01abWk0Z2NqRzRQWDNBQVRBYnRtRXhO?=
 =?iso-2022-jp?B?TzlaZWZCd2JjeFBpS09JZ29rMUhOa042eVFSV1NQSlVOc0dBZHJaeG1h?=
 =?iso-2022-jp?B?N1RDbzFnRnJpbWxUMUVCODJlc0txOUJSZDh6TktxYUx2cjhBNUpyTnNk?=
 =?iso-2022-jp?B?T1FRaXBVLzFKODRGQTZVdXZBQzVZVXZTY0xHQ04xLzZUQ2xZU25jaXF5?=
 =?iso-2022-jp?B?Y2J5bkdyTXNMeTM0cW5jOXRtVjVnZXJmY3BaeXFRREdSazlENndjZGYz?=
 =?iso-2022-jp?B?TFVUeVBFVkExUzBwWTd5UHp6d0pQeWNtNkRZbE1jNGpvY1lrY3BtdEsr?=
 =?iso-2022-jp?B?T0JmdXVuL2JYK3FFZ1dCc3RwUEpYc1VKN2dna3JMUy93Y3UzdWVzOFZX?=
 =?iso-2022-jp?B?TWtSME4xVm9ncUdlRGIrZDFNK1pWL3B2N1RSZkpvbUlmbW9adzJrR1dm?=
 =?iso-2022-jp?B?eG0zV2REWGMyemNGeGVYaTk5QjdIRXJiaUdNY0hOMmNVaXRObDFSUFk5?=
 =?iso-2022-jp?B?TmxicDBlUld5TWJ5eXZMOHBxRGRWUzJ4aFJmdkxla1ZpLzlNRmNST0Q4?=
 =?iso-2022-jp?B?NGhrT2tuWGVHRk9yb1FnNFErS0REU2NEcXJrVmhtMTQxcVF1b2dxQ01t?=
 =?iso-2022-jp?B?dnRORUs4L2w3WllaM2pNQXo0UUJJb29yN2FXMXBFSURrUDFYeXRsc1kx?=
 =?iso-2022-jp?B?TWM3WHZqT2Z3ek9TREhLNjQxMGRVRGhja0I4Y3hrWjZJRXZGRHJvSkxh?=
 =?iso-2022-jp?B?L1NLSUlxQ2JOYnBSUkpUeSt6ZGNOakpqNmFwYUw1MFMvdG42MnpIVURv?=
 =?iso-2022-jp?B?Rm5sQ2MybUdDYTJRUDcwcldaOXBzTHR6bzh0Q3gydlNzZmdXalhPRzdu?=
 =?iso-2022-jp?B?bTNWN2VUYzVFMjZyWm1FaTJvOTl0QjIrYkYwNjJoWVBoMFgvUEcva0lG?=
 =?iso-2022-jp?B?eldoQmkvVkpsQ0JwYnZDOUJaOFZwU0tQWDR0TEk3TERMaXoyN1VHS20y?=
 =?iso-2022-jp?B?NmZiYTJDNkVoaENsNmFhdXJDNFdNdFk3Vm1tR25JQXdCenplSjkrRVhx?=
 =?iso-2022-jp?B?RWhYaWpNczFxYllBZHZDTFlVZ05Fd25CQkhPK1lHNzFZNis0dUptNnd6?=
 =?iso-2022-jp?B?L1B5OWs4TDVIRXhZY2M4cmNvQjY1Snlaeld4K1JRVjdwUnhNT0VUOTV1?=
 =?iso-2022-jp?B?cVlIeklqd2xUa0lBNjA0T1M0RktGWitvWnJpcXJ0OE1ZZ21FK2c5b1lz?=
 =?iso-2022-jp?B?MVR5SmdtWVhRelE3M2M3eStZSmk2ZHJKM0hRcGxyS0tTdmphWC9pUm1x?=
 =?iso-2022-jp?B?UElENHg0ZDIzbHFVSWhIdWxiQTdPVEM1OE1QbFJhL1lqWTk1R0M4VGlY?=
 =?iso-2022-jp?B?blFiQ29ielpDL1BIaTZZYXJ0c3RXMHRscVAyaGJ4emVQaHk2SzRhWGlP?=
 =?iso-2022-jp?B?elJhdmcwaDQ1RzM1UnZBWEd1d005QlBqNG14UWYyUldtb2gyY1Fkd3lr?=
 =?iso-2022-jp?B?Lzhaa2M0dElhQnVuV3lqVEE0MUNFdE5iZldLS3VGS0VUSVBLOW1mL0hK?=
 =?iso-2022-jp?B?djQwK2MzRHVIWVJDd2lyVFd3NGh3Rm5pM1JnVzFkblRDWlBSdjcvOGN0?=
 =?iso-2022-jp?B?blRnc090dyt0Vy9SQSt0UDROMEx2NDBEVDRvMEpSODdRSTRvaHJ6Vkh2?=
 =?iso-2022-jp?B?QmhvZVdjN0ZsYnAzZkhrM0lyY2paY1U9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB15132.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018)(8096899003)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?bFA0eitFZllQY1cycTJSZzgzSk9ZWXZLZG5aWDE0MzRXdlZXa2NqUUIr?=
 =?iso-2022-jp?B?eE1sV29iYUhlakVXSy90V01WWms1RW9mZTE3WVFYd1BvaHhOLzhxeFFI?=
 =?iso-2022-jp?B?ZGlnd0FrbzByWEFNeUJBYkpXeGdSVnlBKzEzVGxBWTYxM0JxSEpiTi8y?=
 =?iso-2022-jp?B?OWNvYU5nNWVkZk9qeXZLTUs5L0tZeTZaVFFicVJWY1k1bUwwNmFrSU85?=
 =?iso-2022-jp?B?TFAxc0xFOGhvRzhSSDRyM2QrOTZNT3B5SnZZTHFXdmZkTDdML2k0U2dI?=
 =?iso-2022-jp?B?RGQzZXB3TVhySGxZcCtla2VGcDNlZ2krL1FMSU1DeW9ZaVF4Zmh4QW9W?=
 =?iso-2022-jp?B?RDFYVnFvSC9kTlV1VUVLZWozZlRLamFTeUgzUnQ3UldmOUNneUVzN3Zi?=
 =?iso-2022-jp?B?K2t2Ymw0R3NLUVBtdHM5Tzk0d1dQNzJZUm1lazlQZVlpcmJXNmM5SEQz?=
 =?iso-2022-jp?B?WW0waFdLOCtBRVNGMng0VG1QU3RzSGJXUk5sN1UvOUJkNm9aSG5vdWU5?=
 =?iso-2022-jp?B?aldWYlJUTFZGcjFqNFBsenQ2bFdQQ3V1R0ZGTEhIVncwUXJ5RThISmVy?=
 =?iso-2022-jp?B?M1VRZVg1ZENveTVaYVhCMVI0TlF3RGtiZm1DUXplOENSL3JldC95d2FQ?=
 =?iso-2022-jp?B?aDEreDVEaTJDQ2VlWlBkMHVCU0pFbHNwZFlIdVUwVUg1c0xBaTJHc1BH?=
 =?iso-2022-jp?B?UGZveXl0Z2JBckZRTHJESTNIMVpjTGJkSWl5bWp0VzJoL3NwQlE1RVdT?=
 =?iso-2022-jp?B?THdBMi9DYzduWm1XZlErTUYyd1VYTWVtR0h0RlF1NlRqdEtzZEg0dlBH?=
 =?iso-2022-jp?B?dk5UQXlsTDNPOHc4b0pqMjQyczNFdHZRVjRMZzBPZk1iOHIrR2FmT1dm?=
 =?iso-2022-jp?B?bnRORG8zQ01iemlMV0dHdlZWSkI0MUJuOVdoR3RhS2ZhdWpXUVZhTmxY?=
 =?iso-2022-jp?B?OEk1WnI0QlZSdHVaN25MTk5EcFliUDlJdDBFeFVIV2xsaE1QQjIzbXh1?=
 =?iso-2022-jp?B?VldldURJNWN1OCsvaFh1aVJjOHlmTGQ5eTdVQ2hGL2hHdjNSREM3OEJn?=
 =?iso-2022-jp?B?R1RLNldtbEdyQlpEUmxVcWkxSTFCYjRkS0JNM3hkY1E5ckRnWHdpTDYw?=
 =?iso-2022-jp?B?T1FyWnZyall3RTJ1Y2tlVkE4Z0FyZnkvWE02VHNDckl4MWZzaU5IT1B3?=
 =?iso-2022-jp?B?Vm45NzRnRVIwd2NVNjlialMvQk5xRmpTQ1ppYUhLNklReEEzNVVDSVZH?=
 =?iso-2022-jp?B?TkEzZGhrWnZ4N3lheE92RDFPN0N3L2VWeWF0UGNRQkNCSlF2ekl2U0sr?=
 =?iso-2022-jp?B?NEJKcFRyWlE0WHRUUWhxVlBvaFdIT05pR2xKSSsvYkJTZEVzTC9BbE5y?=
 =?iso-2022-jp?B?cHBudEJWQjlCcXdwR2diV1NScWVXKzhiSDdvUGl3VkNXOXI0bFkrUUtD?=
 =?iso-2022-jp?B?aVRqa1FFSmNFT255Tzk1RXN4dzBYR3B6cEhhWkFteW52bmp0ZkZTQk5E?=
 =?iso-2022-jp?B?TlVHSTBiM0hPLzN3Nm1TL1Rpd3MrUXdobTZZWDBRb1dRWEhKdHRkMjA3?=
 =?iso-2022-jp?B?Rmhzc2xPeC9CbWlsT0Q2R0lDc0JVUERET3pQWFRBQlRaeG83UjV3S3pa?=
 =?iso-2022-jp?B?T0llYVNZRWVXYURma1FiS2pTYk45UGRaRVhsZEFJVS9ZdUNtSFhyTCtx?=
 =?iso-2022-jp?B?eEpKbmRXTlZaN0UrTzN1aTdKTHBJTXNqUWRDcmh4OXpYYjJHVEg2eWVw?=
 =?iso-2022-jp?B?L09LcDFrbXBVeHBDVmRZZ1p1Mm96ZWg0Q05mSmUzSElUUTNnMFNtTW1H?=
 =?iso-2022-jp?B?dWhKektzOWlsWHlxeDBac3Z2YnJ5UGZ4aklydC8yUHA0NjVXSi96OEpQ?=
 =?iso-2022-jp?B?VWVvdXQwdjVQWklvOVFUTTJzbDlXR0xRQ1ZCSGVlOFIzdGlMMG04NVVQ?=
 =?iso-2022-jp?B?SUVsTnY4Y0phVGtyUm1IUXVHY21McWczQlVnRjdHZVl3TTV2UVRZSTBs?=
 =?iso-2022-jp?B?RG1DOUZyckR5dHR4QlBDQVBLajk0cmVFR0tHcVBHS05xUTAzd1RsQjg3?=
 =?iso-2022-jp?B?c0hZNXdDYjNaZGRxOTBkbXk2VGxkVTdpNHAwWjMwM2liZlhack1rM0dT?=
 =?iso-2022-jp?B?bEtvcnVDTUI4NURLV1FoK29YMWdsanBvaHBUajdSY1NQZGREL3FhQmFn?=
 =?iso-2022-jp?B?RzkzeXljK0NmRnEzVFNIMFoyQklYM0J3bk56Z2VZNWlpV2VBMnN6Zmpk?=
 =?iso-2022-jp?B?MVVLTjdzUFpZTDJoaTBnTWcvc1NYV1FjcjVJM2RtS01DbkRZNmtsOHkz?=
 =?iso-2022-jp?B?d1prbFpuMjhENGJSeklGQll3dnh5cEpOU3c9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_TYYPR01MB151321574499D48D7E7119A7AB730ATYYPR01MB15132jp_"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB15132.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3daf781-b35c-4bd8-f126-08dddf219af0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 13:09:18.2831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dcLDBEYXo0g+Bd5ZJnqmPBr21aBvVw/TGUBhzb/nYeAxf9GWNCdIs2F3Z81m5b99VHLccp9DUN6UXN5y7JUVbFhbgVOmkytvgk4qSHDfGSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11789
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Aug 2025 13:09:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19764

--_000_TYYPR01MB151321574499D48D7E7119A7AB730ATYYPR01MB15132jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Shivanand,

I=1B$B!G=1B(Bve enabled these tags and the required user_commands for qemu-=
patersonc-02.

@Quirin Gylstorff<mailto:quirin.gylstorff@siemens.com>, @nobuhiro.iwamatsu.=
x90@mail.toshiba<mailto:nobuhiro.iwamatsu.x90@mail.toshiba> please could yo=
u do the same for lab-cip-siemens-prag, lab-cip-siemens-muc and lab-iwamats=
u?

To do this, please update the qemu machines your boards.yaml with the follo=
wing:

    raw_custom_option:

    - "{% set user_commands =3D {'start_tpm': {'do':'\"/usr/bin/sh /usr/loc=
al/bin/swtpm_start.sh\"','undo':'\"/usr/bin/sh /usr/local/bin/swtpm_finish.=
sh\"' },'manual_kill': {'do':'\"/usr/bin/pkill -15 swtpm\"'}} %}"

    tags:

    - sw-update-testing

    - swtpm-jobs


Thanks, Chris

From: Shivanand.Kunijadar@toshiba-tsip.com <Shivanand.Kunijadar@toshiba-tsi=
p.com>
Sent: 14 August 2025 14:59
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: cip-dev@lists.cip-project.org; kazuhiro3.hayashi@toshiba.co.jp; jan.kis=
zka@siemens.com
Subject: Effective QEMU devices usage for testing in LAVA

Hello Chris,

Hope this message finds you well.

As you may know, the CIP security images uses swtpm package for booting the=
 devices on QEMU.
we have added a separate tags to devices like =1B$B!H=1B(Bsw-update-testing=
, swtpm-jobs=1B$B!I=1B(B.
This makes the LAVA job specified with these tags will run only on the devi=
ces which are assigned with these tags.

I had a look on the list of QEMU devices on the current LAVA lab, I observe=
d there are many QEMU devices which are not assigned with these tags.
Example:
https://lava.ciplatform.org/scheduler/device/qemu-04
https://lava.ciplatform.org/scheduler/device/qemu-board
https://lava.ciplatform.org/scheduler/device/qemu-cip-siemens-muc
https://lava.ciplatform.org/scheduler/device/qemu-iwamatsu-01
https://lava.ciplatform.org/scheduler/device/qemu-patersonc-02

It restricts most of the CI jobs to use only the devices which are associat=
ed with these tags.
So if we update the same tags for other QEMU devices which provides more nu=
mber of devices to CI which will eventually speeds up CI pipeline execution=
.

At the moment, the pipeline is taking 183 minutes 54 seconds to complete it=
 [1]. So if there are no issues then we can consider to add the tags for ab=
ove devices as well.
This requires the update to each device dictionary[2] as well and also we m=
ight need to copy the scripts (swtpm_start.sh and swtpm_finish.sh) to each =
device.
I=1B$B!G=1B(Bm not quite sure about how to do update device dictionaries/ta=
gs.

So, please have a look at this once and let us know if any help required on=
 this.

[1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/19780=
31660/
[2] https://lava.ciplatform.org/scheduler/device/qemu-denx-01/devicedict

Thanks & Regards
Shivanand K

--_000_TYYPR01MB151321574499D48D7E7119A7AB730ATYYPR01MB15132jp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:m=3D"http://sc=
hemas.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-=
html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@MS PGothic";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0cm;
	font-size:10.0pt;
	font-family:"Courier New";
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#7030A0;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Courier New";
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-GB" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0">Hello Shivanand,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0">I=1B$B!G=1B(Bve enabled these tags and the required us=
er_commands for qemu-patersonc-02.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0"><a id=3D"OWAAM984D0041DC284583BCC533728E0042ED" href=
=3D"mailto:quirin.gylstorff@siemens.com"><span style=3D"font-family:&quot;C=
alibri&quot;,sans-serif;text-decoration:none">@Quirin Gylstorff</span></a>,
<a id=3D"OWAAM8D6B8DD62AF84249A630F97E1DB8A220" href=3D"mailto:nobuhiro.iwa=
matsu.x90@mail.toshiba">
<span style=3D"font-family:&quot;Calibri&quot;,sans-serif;text-decoration:n=
one">@nobuhiro.iwamatsu.x90@mail.toshiba</span></a> please could you do the=
 same for lab-cip-siemens-prag, lab-cip-siemens-muc and lab-iwamatsu?<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0">To do this, please update the qemu machines your board=
s.yaml with the following:<o:p></o:p></span></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp; raw_custom_option:&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;- &quot;{% set user_comma=
nds =3D {'start_tpm': {'do':'\&quot;/usr/bin/sh /usr/local/bin/swtpm_start.=
sh\&quot;','undo':'\&quot;/usr/bin/sh /usr/local/bin/swtpm_finish.sh\&quot;=
' },'manual_kill': {'do':'\&quot;/usr/bin/pkill -15 swtpm\&quot;'}} %}&quot=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;
<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;tags:&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;- sw-update-testing&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;- swtpm-jobs<o:p></o:p></=
p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0;mso-ligatures:none;mso-=
fareast-language:EN-GB">Thanks, Chris<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-family:&quot;C=
alibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA">From:</=
span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans=
-serif;mso-ligatures:none;mso-fareast-language:JA"> Shivanand.Kunijadar@tos=
hiba-tsip.com
 &lt;Shivanand.Kunijadar@toshiba-tsip.com&gt; <br>
<b>Sent:</b> 14 August 2025 14:59<br>
<b>To:</b> Chris Paterson &lt;Chris.Paterson2@renesas.com&gt;<br>
<b>Cc:</b> cip-dev@lists.cip-project.org; kazuhiro3.hayashi@toshiba.co.jp; =
jan.kiszka@siemens.com<br>
<b>Subject:</b> Effective QEMU devices usage for testing in LAVA<o:p></o:p>=
</span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">Hello Chris, <o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">Hope this message finds you wel=
l. <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">As you may know, the CIP securi=
ty images uses swtpm package for booting the devices on QEMU.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">we have added a separate tags t=
o devices like =1B$B!H=1B(B<b>sw-update-testing, swtpm-jobs</b>=1B$B!I=1B(B=
.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">This makes the LAVA job specifi=
ed with these tags will run only on the devices which are assigned with the=
se tags.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">I had a look on the list of QEM=
U devices on the current LAVA lab, I observed there are many QEMU devices w=
hich are not assigned with these tags.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">Example: <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><a href=3D"https://lava.ciplatf=
orm.org/scheduler/device/qemu-04">https://lava.ciplatform.org/scheduler/dev=
ice/qemu-04</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><a href=3D"https://lava.ciplatf=
orm.org/scheduler/device/qemu-board">https://lava.ciplatform.org/scheduler/=
device/qemu-board</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><a href=3D"https://lava.ciplatf=
orm.org/scheduler/device/qemu-cip-siemens-muc">https://lava.ciplatform.org/=
scheduler/device/qemu-cip-siemens-muc</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><a href=3D"https://lava.ciplatf=
orm.org/scheduler/device/qemu-iwamatsu-01">https://lava.ciplatform.org/sche=
duler/device/qemu-iwamatsu-01</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><a href=3D"https://lava.ciplatf=
orm.org/scheduler/device/qemu-patersonc-02">https://lava.ciplatform.org/sch=
eduler/device/qemu-patersonc-02</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">It restricts most of the CI job=
s to use only the devices which are associated with these tags.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">So if we update the same tags f=
or other QEMU devices which provides more number of devices to CI which wil=
l eventually
<b>speeds up</b> CI pipeline execution.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">At the moment, the pipeline is =
taking <b>
183 minutes 54 seconds</b> to complete it [1]. So if there are no issues th=
en we can consider to add the tags for above devices as well.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">This requires the update to eac=
h device dictionary[2] as well and also we might need to copy the scripts (=
swtpm_start.sh and swtpm_finish.sh) to each device.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">I=1B$B!G=1B(Bm not quite sure a=
bout how to do update device dictionaries/tags.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">So, please have a look at this =
once and let us know if any help required on this. &nbsp;&nbsp;<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">[1] <a href=3D"https://gitlab.c=
om/cip-project/cip-core/isar-cip-core/-/pipelines/1978031660/">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/197803166=
0/</a>
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">[2] <a href=3D"https://lava.cip=
latform.org/scheduler/device/qemu-denx-01/devicedict">
https://lava.ciplatform.org/scheduler/device/qemu-denx-01/devicedict</a> <o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">Thanks &amp; Regards<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">Shivanand K<o:p></o:p></span></=
p>
</div>
</div>
</body>
</html>

--_000_TYYPR01MB151321574499D48D7E7119A7AB730ATYYPR01MB15132jp_--

