Return-Path: <SRS0=mjHZ=OC=lists.cip-project.org=bounce+64572+6724+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D1EC433F5
	for <cip-dev@archiver.kernel.org>; Sun, 12 Sep 2021 06:57:41 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37A46610A3
	for <cip-dev@archiver.kernel.org>; Sun, 12 Sep 2021 06:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 37A46610A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id OVcYYY4521723xjAHY1g0ISB; Sat, 11 Sep 2021 23:57:40 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web11.13565.1631429858234997887
 for <cip-dev@lists.cip-project.org>;
 Sat, 11 Sep 2021 23:57:39 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 18C6vIJi021269; Sun, 12 Sep 2021 15:57:18 +0900
X-Iguazu-Qid: 34trwupu8zicJ04wjt
X-Iguazu-QSIG: v=2; s=0; t=1631429837; q=34trwupu8zicJ04wjt; m=QgKravJulEycSG4jlebts7sY7BD5it7Cc5e0cGnhkEg=
X-Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1512) id 18C6vEfL028064
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 12 Sep 2021 15:57:15 +0900
X-Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id D8F511000FD;
	Sun, 12 Sep 2021 15:57:14 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 18C6vEWQ010882;
	Sun, 12 Sep 2021 15:57:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eg4nJJav6YjOv09J7yGks55uwPU9GowDkOLrNSTEB94ZaMDZMmmcstJxFVwO66o/bsIw+SGV0JFBwkoir543a9ewcfjuRyF6/4tvy/cfqinS1qGhZEeOwo4U7wU1hm5k/c5eTgWHnF3V7COV0nVU2WlwV+lmrtTM81mgMlIyecnO2uvBOZAwNgp8Kr0ky8IyiaTCIcI+mzGmloH8nFup0GVPKPiui5HHfe1ZJgqLNnH66BpZzyNAnVL0PJYW0Yw23a98qObXAcHK/6l3YrmGWsYlzoShNigXxMtygBXd/RFbbneskxLkXwaygG1N7jd0CQw5wVQSELhVx4Um9WyTdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=276v7iDyqqKW7NaGVN1rbxlvIckuafNI/6CTX/PD7L4=;
 b=JixUNNHLnrWVeAXYoD5GhspaXWEcC5l+lVs7alG79vYgjBoT1SOeJ+9Ma0Ft4u/cDG49jBHCn3TQ36//T0fIO0Z0NLo79O31NFGCkhvpArsOvp7pTgZBEyGihTdytYAHUBf8sv9c1u14Vh5w9U5hfKrLiyPRAv6xr527Y8mkLKP0/+U74my8QLhK0qSUifVxAZtoirlDiYzM9GseTXlmXrprib+DEmVR1nXcLGIsTwe4RnK59ReLxB2B0Ku9yTeSftnDmUV/Gmwv8HLOFCeNtE16N1LMhBfd61ATS9g9o+/ZIU7PhzKnjn2Y+1Pf59W7tp3ktcHou1WCIFNy2CW1zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <masami.ichikawa@cybertrust.co.jp>,
        <Chris.Paterson2@renesas.com>, <uli@fpond.eu>,
        <jan.kiszka@siemens.com>
Subject: [cip-dev] [ANNOUNCE] Release v4.19.206-cip57 and v4.4.283-cip62
Thread-Topic: [ANNOUNCE] Release v4.19.206-cip57 and v4.4.283-cip62
Thread-Index: AdenowjUUMCvGEfISJyQcrSeNDSKOQ==
Date: Sun, 12 Sep 2021 06:57:11 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB6252E924DEBEBBABA184CDE492D89@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e745f4d-77f2-4636-b140-08d975ba8b9f
x-ms-traffictypediagnostic: TYAPR01MB4718:
x-microsoft-antispam-prvs: <TYAPR01MB471877A0AA7567464996925692D89@TYAPR01MB4718.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: i8o4m1fdBMQ2YG+cheqalC7yrc5497MOFAvZw3gVDonJmGItTVhtGkxJRQ0mXaTWdlFTFIrYyCtvsTqftISHWh9Xnm3oqWnisWUgI6s2wLYMRuKS0moukk5BVXJlUQRKBqHoB50RJgZNntXn5Z8i8EUjxU9YDWF2QpMXABr3+rQanQzxHxU1/o/RT8nY1onU1Eb5pYAEAYrAa9p9nBbnEoimv9cRDWopHbVul5gxiIY8Xzc8DboRDZjAx1OmGchNMQeefyzwWwXljb3fgpXJxo6wWbDNqMYQ1nGWlZnEvwgJufdtbpzXffuswvodvzUei/jrtekDJ+6/2eiJqYK5Ni7dMiS3PM3XvmW3kOmSwP/je+hCXVNgaJKPW3zYOUt3tiY39ekhKsFyW+9rduwKBf6jcB/uvpd+xA6tsqyb6CjN1Vdv/BLQI2oelwVT5VUMhlvxMYXCY07Y3eP1SbNodx9SvUAEoR7Zsh/ZTATzR8jbq3OpTO1lQBk+KQ0q2BYOvtS3+CJpzLuIcGcbnA5r9hfIr+/gI34fJ9d+qNdGpGJtpuQjCoH/V2a3V92mNY3iB+bKWHDhtpptqpT3JaJvjGTODp7AH/gBf3j8BclzMoJFYAyNmN/agzNgO3aO7L6alHZuHIGSbPhGhVAeRdqjPjNt1NUA7umNcdKrgM0Ze7uGMwsJJNy7OFMghDTOfW9Bbf5uJHMBb+9VyXaHcHPbP7X/mSGR3CDRNuzzuMzQATmZLG5uOv7ITxhlBdYm1HWcuu6HJ2Abqs4tl/0DI1UmohrAtYhC6f4s9kB7DqqVOY4=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3RrSnZYR1hiRnU0bHRqZmdNbk4ra1ZWeUxweXZyYmFnYm5sSTdLMnNGd0lP?=
 =?utf-8?B?cFc5UU9Zd1Vyd1pLRDlKQ0tXcU5JakNzeEpBYXpvQXZ6R0pacXo0UDlrb1N6?=
 =?utf-8?B?cFo3WTh6TjA5ZDI0Y1dKalNhc00zWmRWODRjQ1YwanFyTUlSTkQzVjVpV1Jq?=
 =?utf-8?B?eUJKc3Q4VjAwa2g5SVB5bUZ2UHJMY2U5MWxDY21RWVc1WDFKd0puZ09vcmNy?=
 =?utf-8?B?YTZiYkNqeG5FZUJIY1cyNGExV3IybDlGOGtjRy9ZTWFUZjc2dGIvdzhBV3JI?=
 =?utf-8?B?ajFBOWtMYVZ3L3MwYy8zSUdZbkZtYVc2V2JBMmVjeXlWTmsrcTRabjBYVUZl?=
 =?utf-8?B?UjdwMmJMRDMxaVF1SGFJKytvZHQvZURGQlBQL2EwRTZiZHphWi8yL1NnTUpR?=
 =?utf-8?B?UHNFQmZkaGdqUHhSejN0cjJvcjd5bm5UVFp6L0JIVjRkN1ppdlF6QjBSQ1BK?=
 =?utf-8?B?ajI1TEN0bGlTcmxLQS9UeUYwUzhSWXh2SjRnOG5QNGc5RXB2MFVQdEFLQWFo?=
 =?utf-8?B?cHZaaEJMb3hPUFI0N0hsRzFjcmpBREhuOU96ZGVOeGhvbC9uOVB6NFpsenZa?=
 =?utf-8?B?R2tDc2YyUlQvOE9sZDk3bVFsTWNzZ0tQZCtkaUFRUkRqZFhLdnZGY0xZblFQ?=
 =?utf-8?B?MW5CWms2aEc4Z1BIVjhURVRwM2FqR0xLMS8zcm56aWZDOXJHaEd5UDVUdkFQ?=
 =?utf-8?B?ekRCZzhKZ3FLam1JcHBTOWxQb2VPU3VOSnlXUnpYeDQzaG52OTJ4RDYvWEll?=
 =?utf-8?B?TWltMDhwalNtYmhoRzdUSU1JSm1QbXVRVmRYWG5Tak5BRWdzNlIrQlhSZmQr?=
 =?utf-8?B?d3VLYkwvYis0MXRpc0RSMk55UW5YQ015NWdCQ3ZidFNObzlYTjU1VVdqT2RW?=
 =?utf-8?B?TEY1RzlhTml4MnRjNExUM3hKU21vYUY1Z3ArL09Zdm1odlE0K2JROW9xMVpa?=
 =?utf-8?B?djNZR1hXMTRONURpUkdZMGNUZHliNy92em1rZDdCOVRhR3JZR1J3UVh1SDFz?=
 =?utf-8?B?Qkh4eEhlN1JPUi91OEJOYjdNVkVWbE0yNFVpT2UvdUxzQlFGNml3enBnUEo1?=
 =?utf-8?B?cEVjQTRDdzBYR3IwWUExWW1hYjdPclZSMTQyN2x5S2lzMTk1WlUzT09UdHRT?=
 =?utf-8?B?OW92ZDJOT3BmeEpUZHQzaEgvc2VPNlBRQUhMSGxOWEJYamZXWEFUUFBqN3dL?=
 =?utf-8?B?bGNtQ2xQWmFxVHVLQ1dLWjRPZXBXMjYzaS9jeGIwOFVlYWR1UmhyM3dMOVpC?=
 =?utf-8?B?NlEyeUVVTUhScndxd00xVHJPRlltbkJWRWVpMzY4aEE5OGNCdUdvTGxQKzJV?=
 =?utf-8?B?SUJWMlFmR3lEeTlrb2dSWkxRc1FRVXBUdGpxcGhRVzlXYmpKUWg3T1UyU1Q0?=
 =?utf-8?B?M2FBaXZsd3Z6TUtFbmR2VG1od0ZzRkQ1blhTSDh6Mklzamlsa0FvUTA0clMz?=
 =?utf-8?B?RFFhK0NxRWo0OHdrem45aXR2ZmxNTGVFTUZOR1E0NGE2RmtkY2JQQ0lqUjFI?=
 =?utf-8?B?clM4ZTB5Ynk4aHNxaGtUU0NMc0hrNldZbWg4dzFoVTlISTI1RXJ1SHZyYmlm?=
 =?utf-8?B?dDZuMkg1MmQ1QWNGMzJLU1lSSmlRRUpicGxzNDVQc1hHWWhGdFBQcTJVT3ZP?=
 =?utf-8?B?TTBYb2wyTk5zR3RWVUozOElPdVpxdzh4NEtmd1NqVFhnOFhGRlR3RWJwbS9l?=
 =?utf-8?B?STlvVEo5OGY2dW5BUXY1cGl3cWttWHR4TTdVWEYrd0dMa1VyRlI2U053SEpQ?=
 =?utf-8?Q?KwQYhomlFlAHqTMayUPkChIwrCnlA0491xjw/Nj?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e745f4d-77f2-4636-b140-08d975ba8b9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2021 06:57:11.5605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zcd+CW1aOtSe3e2+Tz/otoEkD0LosJvfShs50JWu6vjpRkLaESJtfdVY+pkd/JdTXGdhbQ8z56AjocRiND0zPCgURznDtkiZ9yisORxRyrpBE7DLHS2NreWD9zmbUaZT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4718
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: T0t3eTNkcAgYy1T1XRhtWbpox4520388AA=
Content-Type: multipart/mixed; boundary="89ybisl6R7c9nrxYCblC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1631429860;
 bh=1ZaeyaztUqV/YPLAM3n+f13n0SMXcf59e/trDosPY1I=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=poEt2nxKLkwxLe+gfXidTNqcmMhPmyX0+Z9ptOulMgkN8lfADxDBo8OE+Pk8+/wB/bn
 fgniCv6LX0Tk2PivsXe2sy6RjVc7VzvfPYdrj+oN2sBJeBDgezG9sQD738vwy2ZgSoAgy
 zrPfsUQXbm6dhS8n7gtt0GdBA5qMSPml61o=

--89ybisl6R7c9nrxYCblC
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQpDSVAga2VybmVsIHRlYW0gaGFzIHJlbGVhc2VkIExpbnV4IGtlcm5lbCB2NC4x
OS4yMDYtY2lwNTcgYW5kIHY0LjQuMjgzLWNpcDYyLg0KVGhlIGxpbnV4LTQuMTkueS1jaXAgdHJl
ZSBoYXMgYmVlbiB1cGRhdGVkIGJhc2UgdmVyc2lvbiBmcm9tIHY0LjE5LjIwNQ0KdG8gdjQuMTku
MjA2LCBhbmQgdGhlIGxpbnV4LTQuNC55LWNpcCB0cmVlIGhhcyBiZWVuIHVwZGF0ZWQgYmFzZSB2
ZXJzaW9uDQpmcm9tIHY0LjQuMjgxIHRvIHY0LjQuMjgzLg0KDQpZb3UgY2FuIGdldCB0aGlzIHJl
bGVhc2UgdmlhIHRoZSBnaXQgdHJlZSBhdDoNCg0KICB2NC4xOS4yMDYtY2lwNTc6DQogICAgcmVw
b3NpdG9yeToNCiAgICAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L2NpcC9saW51eC1jaXAuZ2l0DQogICAgYnJhbmNoOg0KICAgICAgbGludXgtNC4xOS55
LWNpcA0KICAgIGNvbW1pdCBoYXNoOg0KICAgICAgNDI1ZTM4Y2M1ZDM3MjIxZTFlMDU4YWRiYTEx
NDcyMTUxNmFjMTZkMQ0KICAgIEZpeGVkIENWRXM6DQogICAgICBDVkUtMjAyMS0zNDQ0OiBicGY6
IEZpeCB0cnVuY2F0aW9uIGhhbmRsaW5nIGZvciBtb2QzMiBkc3QgcmVnIHdydCB6ZXJvDQogICAg
ICBDVkUtMjAyMS0zNjAwOiBicGY6IEZpeCAzMiBiaXQgc3JjIHJlZ2lzdGVyIHRydW5jYXRpb24g
b24gZGl2L21vZA0KICAgICAgQ1ZFLTIwMjEtMzc1MzogdnRfa2RzZXRtb2RlOiBleHRlbmQgY29u
c29sZSBsb2NraW5nDQogICAgYWRkZWQgY29tbWl0czoNCiAgICAgIENJUDogQnVtcCB2ZXJzaW9u
IHN1ZmZpeCB0byAtY2lwNTcgYWZ0ZXIgbWVyZ2UgZnJvbSBzdGFibGUNCg0KICB2NC40LjI4My1j
aXA2MjoNCiAgICByZXBvc2l0b3J5Og0KICAgICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvY2lwL2xpbnV4LWNpcC5naXQNCiAgICBicmFuY2g6DQogICAg
ICBsaW51eC00LjQueS1jaXANCiAgICBjb21taXQgaGFzaDoNCiAgICAgIDgyM2RhNGIzMTJmMjE0
YTRkMGY3NTBmOWNiNjE1N2RjZDQ3NzY5ZmINCiAgICBGaXhlZCBDVkVzOg0KICAgICAgQ1ZFLTIw
MjEtMzY1MzogS1ZNOiBuU1ZNOiBhdm9pZCBwaWNraW5nIHVwIHVuc3VwcG9ydGVkIGJpdHMgZnJv
bSBMMiBpbiBpbnRfY3RsDQogICAgICBDVkUtMjAyMS0zNzUzOiB2dF9rZHNldG1vZGU6IGV4dGVu
ZCBjb25zb2xlIGxvY2tpbmcNCiAgICBhZGRlZCBjb21taXRzOg0KICAgICAgQ0lQOiBCdW1wIHZl
cnNpb24gc3VmZml4IHRvIC1jaXA2MiBhZnRlciBtZXJnZSBmcm9tIHN0YWJsZQ0KDQpCZXN0IHJl
Z2FyZHMsDQogIE5vYnVoaXJvDQoNCi0tIA0KTm9idWhpcm8gSXdhbWF0c3UNCg==


--89ybisl6R7c9nrxYCblC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6724): https://lists.cip-project.org/g/cip-dev/message/=
6724
Mute This Topic: https://lists.cip-project.org/mt/85547773/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--89ybisl6R7c9nrxYCblC--
