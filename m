Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BEDC02182
	for <webhook@archiver.kernel.org>; Thu, 23 Jan 2025 09:02:29 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.7120.1737622944913165133
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Jan 2025 01:02:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kazuhiro3.hayashi@toshiba.co.jp header.s=key2.smx header.b=SWPAM3SX;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=kazuhiro3.hayashi@toshiba.co.jp;s=
	key2.smx;t=1737622943;x=1738832543;bh=HWrnCN6YLeCmjOKeSpsyG9+g3pdfXXWSZRBDHzd
	8Tm4=;b=SWPAM3SXmF3IIRRl6nwlC+bsaS1/5Do5On6NQyCttX0fg6I0R1VSo3Ax7JxW2eFJBbeey
	0fgcBgDDHke8OptoxUV2GHjOrEwd62VCVt1cPvwh3W5tXGo49SetwjVza7eyoA/1xrwlLd0dKUQr8
	sFjJk0iSL7J3JkgT1aYUVkX58VpkUpM/VYOCvbwrPjn/ZVG9kcbdEwZhUEf9Yb0khafhjpxES6S7/
	6sadGErzqYWLD2ilRIDXSo9bztKcsjoYNiGDxNtUgGb3Yh0piz5Z36dihyNdO7cKQf5tLZNzlObcj
	vBu1RMooBkZQB71rePA3knAM+sYfLlb/+pLe0eLEcg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 50N92MSW2929086; Thu, 23 Jan 2025 18:02:23 +0900
X-Iguazu-Qid: 2yAbpfLvEnsyF2Ql7Y
X-Iguazu-QSIG: v=2; s=0; t=1737622940; q=2yAbpfLvEnsyF2Ql7Y; m=iAkY4j2GEPxSqAz1uwYUdyC90chvMm5D57eRt8vPTg4=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 50N92Jsq2473763
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 18:02:19 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNQX+ws94/wxkZosgpF6jidWZAnJKyZMkIwW7TuierglWaVfTudtJ2hvpx1MTdwtOIEuWZ3BOrIZJufNKeKqNmBjDafGZ97ExqCHsTtR/vEyieBc5ZsXuSXFE1WZW8Z5otlJW+Io0r9Qrjh7uc1TuQdmJPaAZL/pHXubYOoHlwGWq23rjQTkH89oVHacfZi39fXrVX3nNZ5mNoeRY61m4OjWIV4SQRY3zgYCcS+92hGe6tmc66UAiQxq9HMMzcuOzY0vkzhvp4JFqW3AIj7C8JEtvPRsnI2UH67YYz3p7kg1hXU5nj/w+iGq92lA8eDKQhpTieeFOwLZY5uO1tmslw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKccXtSKNwNuBst+HGCpwN+QRVeQnvpTE9iqdV8Q53c=;
 b=X5K+OE2N8amZFO1mKZ5Y8ZQw+FNUjxhu7BgR9wvLDJ4MkUsfva1bbMS1NmHMExcqL8PcXMZnhRW4ix7rK2bxDWECAqGng6HZA/+7e+I1Li94zjSzMsVBs5i96AjuzHgCCo7EmhL7xGgRTbhltUb5j7yunn4SUfVQGdJ42ExFFK+uZgr6p4FjYCG/qepLjXVVGO9WBoMDipBBuYFhcoxP9b4EeV6MJ19ffv8vr+oLblmHgNT9vB/HrbVbQ8JMAhJch2xEGfCK3uK2q+gNVVLPonBfrNJj5ifu/3oUKjzt+cOrzqQzna28zNDbRZl1a6zMMjaAISJDC1lHaweEMSQd3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [4.4.y-cip-rt][RFC] Repeated WARNINGs in
 unpin_current_cpu()
Thread-Topic: [cip-dev] [4.4.y-cip-rt][RFC] Repeated WARNINGs in
 unpin_current_cpu()
Thread-Index: 
 AdsJh4OWhCfjKTeTTpWNGegB8O3M+wKZptcAAyMC8oAGUKjG4AHAfXyAACXVkeAAPI+ogACE0nfAAjnJmaAAkRe6gABlpKzgBe04HoAA8CxzMAAdclSAAAvSl9A=
Date: Thu, 23 Jan 2025 09:02:16 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB11385F1B3D21415216733E9F4E1E02@TYCPR01MB11385.jpnprd01.prod.outlook.com>
References: 
 <TYCPR01MB1138579CA7612B568BB880652E1272@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <Z0cBKfpz3I6pA4MW@duo.ucw.cz>
 <TYCPR01MB11385501FC495E0F4E531A749E1292@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <Z0mVe42i41SXemYu@duo.ucw.cz> <180D3C69AE13A59C.18476@lists.cip-project.org>
 <1810B3A8127ABE18.31077@lists.cip-project.org>
 <TYCPR01MB11385C6C2D03D46AF20294DF3E13B2@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <TYCPR01MB11385C4C5CA765090E66944FFE1052@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <Z4o+Ue8yk1aDpmoC@duo.ucw.cz>
 <TYCPR01MB11385BAF7D5C56CC8CC378440E1E12@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <Z5FPtY4aUHqMoL4w@duo.ucw.cz>
In-Reply-To: <Z5FPtY4aUHqMoL4w@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11385:EE_|TYWPR01MB12005:EE_
x-ms-office365-filtering-correlation-id: 68625467-badc-4f16-71b2-08dd3b8ca253
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?dEZScnJvOTRtdFVlREpCQWtLWHFMWU9BOTR2dFpDUXZqblRzV1ROUkVK?=
 =?iso-2022-jp?B?ajF2VmpIaEk5aWVDRE5iakZtMlpnbVZ2OE9aQVFwNkt5V2lGZ1ZrVXRl?=
 =?iso-2022-jp?B?ajFqV3kzQmZpemRBYms5cjBxZkRZUmliV2VoNjRUS1NMSTA3MFZaOGJx?=
 =?iso-2022-jp?B?b3BjV3ZIdktiZWl2WTNIQ3lWb3lyemF0eTZ2clljN3hkd3piK1Z4WlYr?=
 =?iso-2022-jp?B?U3RBcm5OVnFnc1VFTGxLSDgrWk82TW1xZXNjblVSa3R4ODVqdklnaVBr?=
 =?iso-2022-jp?B?bzF3bHRBWmQvVzdPeWRWYTNzZ0UwaEMwYnh6S3R2ZGhQUkNrUXJFekxh?=
 =?iso-2022-jp?B?MTE1Rks1Sk0rK0oyK2VSLzI2MzdpQzFDY0o4emtGbGxaTzVhbGV6UXRC?=
 =?iso-2022-jp?B?L3Uzd01udTE5bmNhK3ZPWGE3dmZmY1FIUWNiVnQ4T0xjT2tnZlhhZjV6?=
 =?iso-2022-jp?B?UUF5aFFNVkNQSUVYZUNUYXNpYm16WG02TFMyZlphNkZHWTQ4bkxKN0hM?=
 =?iso-2022-jp?B?MmtxQTY0S0hwYUZyK3Vha3pKY3IyY00xQkErUzRMRk0raUNWaStFakFH?=
 =?iso-2022-jp?B?dkRQSHE5Ry9yR3FIS3RUYW1yWEtMSS9NajdEd1hSWlI1RUpRSEh5MG9S?=
 =?iso-2022-jp?B?T3VnTEZKSXVNYmZnZFlPWW1jQUR2S1FjTEhKVWVKakpJZzg5ZWNsVThU?=
 =?iso-2022-jp?B?amRUTEt0NThNRVFMNWhhMEJYZFVVQjh6bXZhVSt0RFJ3WkJ4NktuOXZu?=
 =?iso-2022-jp?B?WlFkRUxvUlV0UlBoTkVrU01UZDFCd0VaS0NmUHBEaGpyL2hkUThiVFN6?=
 =?iso-2022-jp?B?dXV5dDMxaG9jOXc4K09YbDJjYTBrUHdvSXFiWFpabFFsVnBtR2IwR3gv?=
 =?iso-2022-jp?B?RCtlclM0Wkh3M3dWNmhuQmZYc2c0dndQRHFnQ1RoSm1QU2ZIRlpqWDhn?=
 =?iso-2022-jp?B?c0pZcEpNc3RVY3BSYmE2eG1Jb0xzaEJQdXgxaTR1dXltdVBUWTdGYmRh?=
 =?iso-2022-jp?B?SmxKa3lUTUxKdkxPT1VlNE9Iajd0ZjUySjFDdEF6ZGlydE9ReU9oTkht?=
 =?iso-2022-jp?B?WFdXa3d2N3BxRlBXT0N6UjllbUdUMFpaczU4WE0rWjJsNUVYWHBhbUlq?=
 =?iso-2022-jp?B?NVZ4Q0pJU1NtZWd2OWo5akloMnRXNXFXaFVZbGtqOFE2bTc5Rkh5b0xF?=
 =?iso-2022-jp?B?RE04K0VXaDJkR1JtcXp3Z0NHQlJ6NXdsRVFKeG1aK3MwTUFwbjRoaEYx?=
 =?iso-2022-jp?B?OUZCVXZSejJZZi9xNkt5VmR3emdLL3B4YklRR1RDTk9iQmxxSmtHNjdH?=
 =?iso-2022-jp?B?OFhsTWZaSUdRUG9wNjJOM3Y5eGNCMG1SUnp2b2dvMHpncER4dXd6eHN2?=
 =?iso-2022-jp?B?NWJoY1NoajQvUCtFOFRpTllWSmhYclNKcWxQVmcxK21vNmF1SThKOW0y?=
 =?iso-2022-jp?B?TjNaYTRUY2xwUWFGRlJXVmtRRjV0VHJZMXBNNWdQNngva1oraHNFTko2?=
 =?iso-2022-jp?B?emRjQmh2Wisvckt2V29DZEpobFcvenc4SHlYZUVyWFFVV01kME5UcHNC?=
 =?iso-2022-jp?B?WUtPZllVaVNxS255OU1GOSswUTlsRWladlhvRklveURzQ2oxR1lSbTdm?=
 =?iso-2022-jp?B?WTlhdjFoWWFJaDFBTXBsRENoRkg5ckwwdDJMdEtwUWZEL0lxQS83bEpq?=
 =?iso-2022-jp?B?cjN3VGpqUklqL3lId1BUY3NubjV3ejJXaXhuNG82YzJCNmxrME5CVk5i?=
 =?iso-2022-jp?B?dzBqalNRYW5qdC93dml4TUthTXdwalpCN08wdHJoVXdZbGFwWTFBZmJv?=
 =?iso-2022-jp?B?R3dCdUhWcmwyTjFxTWxBaENaRHhITnEyV085WitQRUxxQ1JUdzNjQ2pz?=
 =?iso-2022-jp?B?VSs1RHV6bFYwRDRtdUwwNFJLS0NNekgrUE1JMGZtMi9sSlpaQW9rSDQ3?=
 =?iso-2022-jp?B?TzNmUFdqU3h5Z3FZT2Vzc0ZIWmR0TzBaKzJUUEdiSjgvSm1FRWVoa2Y1?=
 =?iso-2022-jp?B?NEJFMVhON3RwNEJTdWxOcGhLMGR4S3RoR1RwYlNqcjFRaCt6SDNkUDVZ?=
 =?iso-2022-jp?B?R1I4OFZjVkZLWE9Qb05tc2ZIR0R1NDA9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11385.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?aHVYK3dTNFFncUZBc3VBMm5GRXFkb3R3bFE3d3RudXpGZTBGY1FCZXV1?=
 =?iso-2022-jp?B?azUvTmsvYUdSbVllUW1sRm5EcHUrWDJ1WHJpQzNXUk9yM0xJQVhZTlVI?=
 =?iso-2022-jp?B?NFZSUWtTWkJBMEtTVFBmc24waThuK1pNY20wMXQ3Y1FpaERwNzdreHJr?=
 =?iso-2022-jp?B?MWFLOEhyMktiaE1Na0tvVFVNUGVrMy9Mdmg2NzFEMGxrRXlCUzRkMEZa?=
 =?iso-2022-jp?B?eVFpWDFqNmtQSFQyZGJidDd0WTQ5djRhcm1yWkkydUxQTmtWL2lRUzhh?=
 =?iso-2022-jp?B?bENxbUNxaDEzdzdWUSs2VlIxRHVCK0hwaVgvYlB5b3dhbHNOZzZyV1Ev?=
 =?iso-2022-jp?B?ZEkwb3pGLzBxSUNnUDlpN2RYalRRbXlyNWlUVmoxK1JFWVhmOUp2NTJw?=
 =?iso-2022-jp?B?VG9ZNnZaajlpQkNSbnZPYkRIK3RCbk16RzAycmp3Z2JPVWI4TG9jOE13?=
 =?iso-2022-jp?B?L0JuamhLTjVseU9FVXBLNXZqVmNtWHYvSy9oRjdIS256ZFlpcEl3eU5q?=
 =?iso-2022-jp?B?amthbjZiMXZwcVc1REhydnpTWStFV0xPM04zK0dkaWY1em1BYnJPZ3lI?=
 =?iso-2022-jp?B?Y0ptMm0rKzg5cUZrOTRvVTZ5OFp1RDI5bkRFdUN5Qm9KOGtuSDUvVk0w?=
 =?iso-2022-jp?B?R2gzU3RYemt2MVFNblIrWjZTbmpvU2N3QU1vSFhneTNBdm9zTzRxWlpO?=
 =?iso-2022-jp?B?UFVMNnF6eklNUlFiYzVkTmoyV2tZVVBtN0szd2o5blM5WWZOcFRvcHVa?=
 =?iso-2022-jp?B?QXV2L1MraUVqd2ZackI1MGhCc2xTa0xORzZrTytMeXoyaXdTdFdoU2U2?=
 =?iso-2022-jp?B?TEVVbzMzL3ZBMTliRU9MY3lHT09CWXcyWHB4OTlXY2JnWEhwV0F5SzRX?=
 =?iso-2022-jp?B?SjhXc0RPZ3Jybkw2N2hIN2g4UllrazRwU2U2T1JxU2s3amZLTlpURGtn?=
 =?iso-2022-jp?B?T2V6RGc1VnZiNnZKcFhLdXVEUS9PKzFTcmc5dFBnNERkWFJFNm43eTJx?=
 =?iso-2022-jp?B?eWRzU3lzZzUyNE12a3d3RXo2V0thMVFEZkZTWkZDN3JFMjJiQ3lQbVlR?=
 =?iso-2022-jp?B?R2lEQmpOZHNRdGVPTG13RlkyWkFuYTBxcW1lODU5VVJ5T1ZlTTRhNFAz?=
 =?iso-2022-jp?B?Ym9rRThBUlQ5YjMyZFFIdUttdGNEdTlHbXlacEI0N0I5ZDg2Umg4OXpu?=
 =?iso-2022-jp?B?N2NQbk5VTitnWlB1aFhld0tRNUFkNzJyNzBIL1UwUHVFditRdFBQOFdo?=
 =?iso-2022-jp?B?Vm9XQW1tbHJmZ2JoS3gzOFdUVWdVSEJ5MnluT0FDdm9kMnN4RkFFdGhN?=
 =?iso-2022-jp?B?TFdUVm1RTC9ISHpDRGJsWFhYMWNGS3o4ZHlhL09LbmIwdFNjb1ZSdVcy?=
 =?iso-2022-jp?B?NmJMQXJMUzhHL0FUY084eDJnOTVCb0ViM1oyVER6VWFUSGJvT2VUWWtP?=
 =?iso-2022-jp?B?TUVVOCtXSm5yaVhiUFVsd1lGc0s4V29XUU9nbU85K1RwdE1FQUFqTnIy?=
 =?iso-2022-jp?B?TVVuTkl0THpNeFUybGxYVlIvTm1VK3lYaWtUbFFJSHRRZFR4RGl5T3dX?=
 =?iso-2022-jp?B?Z3NMS0NlcEFKaWk0dnFPU3J5cEdHdWcrL3lmUkw3NGtlOEdELzcwS1VT?=
 =?iso-2022-jp?B?cWs1cExPNWxOM2lUZGV5T0tzeUJYTkcrblRNNmpSWFBFNVVMbENyMURu?=
 =?iso-2022-jp?B?WTRwNWdCTVNILzg0VTEwVXV5bzMvVEdKb004UHhiVDkxQksvUzIzZ2sr?=
 =?iso-2022-jp?B?NURqZTVIVnJENDFaTldkMTRiTE4vekxCSXNvUWt1bDZkRnZKQXJLbVF1?=
 =?iso-2022-jp?B?MnBhMmRLRjVpaHZIUllGbEVhNDBLU081MWxkeXRzbS9oS04rQXZUa2ZH?=
 =?iso-2022-jp?B?cGJVcnFGZnBHbDZzMGFqTkd2ZzVEdERWT3VObW9PVmRKclVYUFlhNWZ4?=
 =?iso-2022-jp?B?SWJJRXMwSmtzUjJKQzFBQW5aNzN5MFRnWWhsbkNGdlE1QVF0V0Y5YXFz?=
 =?iso-2022-jp?B?b3NiSzBObDN3U21WUTM4TWhhK1ZINC9SMS85d29IRDJSOUt5QjZleUVQ?=
 =?iso-2022-jp?B?M2YvYVF6bkxWYnRvVEZQM3JvODR0WlhyWExzbk9GSFBSTlhNODhTTmFv?=
 =?iso-2022-jp?B?N0Q2OXdkN0tSWldzdnpYbmZvcEhQSU5laXNZVGdUYXJ1WVZkVFp2L0wz?=
 =?iso-2022-jp?B?UjdQQjBwaVFWOE1kbmViSyt2NHpqQzIzYzN3UFZvOUozQzZaSnBxVUZh?=
 =?iso-2022-jp?B?Wm5qSWUvc0JpSXRjalFPNEkxcjJHeDJ1UytiWHpQdU5wbzh2aUg3emNG?=
 =?iso-2022-jp?B?dUlReUxlaE9CRk1DUk1KUHZlSmg1MEJZc3c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68625467-badc-4f16-71b2-08dd3b8ca253
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 09:02:16.0698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bb5cOQ1C538jbxgk1P2b4H1Mq/29YYAl0meIibT+xbRftIAmZrcqGoucteF1Jxoqcw59G/p3GLDVRFXB83oGEJxp3iXQ1HSnefKPDx0JDP1un7lqoMfUce1X/3LuPS5W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB12005
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Jan 2025 09:02:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17607

Hello Pavel,

> Ah, ok. So... this is the real fix, everything else is just a
> preparation, right?
>=20
> +++ b/mm/slub.c
> @@ -1412,7 +1412,7 @@ static struct page *allocate_slab(struct kmem_cache=
 *s, gfp_t flags, int node)
>         if (gfpflags_allow_blocking(flags))
>                 enableirqs =3D true;
>  #ifdef CONFIG_PREEMPT_RT_FULL
> -       if (system_state =3D=3D SYSTEM_RUNNING)
> +       if (system_state > SYSTEM_BOOTING)
>                 enableirqs =3D true;
>  #endif
>         if (enableirqs)

Yes.
The 0016 above can be the fix for v4.4-rt (and v4.9-rt too).
It depends on others (0001 - 0015) that introduce SYSTEM_SCHEDULING.

> But I'm not really comfortable applying this to our rt trees, without
> it being applied to 5.10-rt and others.
>=20
> +++ b/include/linux/kernel.h
> @@ -481,9 +481,13 @@ extern int root_mountflags;
>=20
>  extern bool early_boot_irqs_disabled;
>=20
> -/* Values used for system_state */
> +/*
> + * Values used for system_state. Ordering of the states must not be chan=
ged
> + * as code checks for <, <=3D, >, >=3D STATE.
> + */
>  extern enum system_states {
>         SYSTEM_BOOTING,
> +       SYSTEM_SCHEDULING,
>         SYSTEM_RUNNING,
>         SYSTEM_HALT,
>         SYSTEM_POWER_OFF,

My understanding is that you don't want to change system_states list and
related codes, which will make future backport efforts difficult.
I fully agree on this.

Let me clarify a point here just in case:
The patch series above (0001 - 0015) is already in mainline v4.13* or later=
.
https://github.com/torvalds/linux/commit/69a78ff226fe
Thus, even in CIP:
https://code.tosspedia.toshiba.co.jp/linux/linux-cip/-/blob/v4.19.325-cip11=
6-rt40/include/linux/kernel.h#L580
https://code.tosspedia.toshiba.co.jp/linux/linux-cip/-/blob/v5.10.229-cip54=
-rt23/include/linux/kernel.h#L446

> Alternative, AFAICT, would be something like:
>=20
> +++ b/mm/slub.c
> @@ -1412,7 +1412,7 @@ static struct page *allocate_slab(struct kmem_cache=
 *s, gfp_t flags, int node)
>         if (gfpflags_allow_blocking(flags))
>                 enableirqs =3D true;
>  #ifdef CONFIG_PREEMPT_RT_FULL
> -       if (system_state =3D=3D SYSTEM_RUNNING)
> +       if (system_is_scheduling)
>                 enableirqs =3D true;
>  #endif
>         if (enableirqs)
>=20
> +++ b/init/main.c
> @@ -412,6 +412,16 @@ static noinline void __init_refok rest_init(void)
>         rcu_read_lock();
>         kthreadd_task =3D find_task_by_pid_ns(pid, &init_pid_ns);
>         rcu_read_unlock();
> +
> +       /*
> +        * this corresponds to system_state =3D SYSTEM_SCHEDULING in main=
line
> +        */
> +       system_is_scheduling =3D true;
> +
>         complete(&kthreadd_done);
>=20
>         /*
>=20
> Which is same thing but less intrusive, right? I'd like to see that
> submitted to -rt lists, too, but it may be less scary.

Thanks for sharing the concrete idea.
Now It's clearer to me what you intend.
Yes, it's less intrusive.

So now we have two examples:

(1) Apply 0001 - 0016 to v4.4-rt and v4.9-rt (but not acceptable for -cip-r=
t)
(2) Implement another flag like "system_is_scheduling" above then apply it =
to v4.4-rt and v4.9-rt
(Again, no need to suggest (1)(2) to v4.14-rt or later because SYSTEM_SCHED=
ULING is already there)

Correct?
Do I need to share the both ideas to -rt lists?

First, I'd like to make a draft of (2) then confirm the repeated WARNINGs d=
o NOT occur with that.

Best regards,
Kazu



