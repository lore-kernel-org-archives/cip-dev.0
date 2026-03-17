Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E0EFD875A
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 12:15:58 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.74398.1773749748902126955
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 05:15:49 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 62HCFkPm1495192; Tue, 17 Mar 2026 21:15:46 +0900
X-Iguazu-Qid: 2yAaeSlrlDI9dU8IqW
X-Iguazu-QSIG: v=2; s=0; t=1773749746; q=2yAaeSlrlDI9dU8IqW; m=NMrm6RTMSV9vz38CkaTNqLJXb6evPwyVyYQicAU0pZU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fZrX214yYz1xnZ; Tue, 17 Mar 2026 21:15:45 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhl7ws+QKjdy4KEO0AbgZZ49dOo1xowCriYMMW8Zj58XnY+xsZIBROMN8LKe0FpPIe9r0fb+GiusOhlcDLVAaQWjFhtvwYbpRoxMrdFjzpOo3F04Jvgtwop8j1SkSwr3LeUcVMLdWXqA0ttHUuzDScT7QDFVcqLrLUY3GpF+5JFYDAI2xGp8VmXEH96rcpzLdnjqowYLTOQ3703yOqveemO4Vp7qvXjks3OChyjkZNUHJ317T3LVnu3bZcaUXqriIL8dg2Gk10GrizetznugNNlnEKlKiPc/h9/PmoaruipRoguJFvBKkfZiEQeE0zeeira+Z7vZGnyLvq5E/gkPBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8nqvVfT2cv+BN6kIzCHmuCygeFGOLIwvfpc+q4UqGtE=;
 b=Q4Gb+H6dqqq6ukJsguSoONXmUcbvK8SioIWUrjTunzJwI6Le5HyCW18XANUaRWms/QOk7HZjToxiG1BmvoFv60gZr5sUtlnYvoSw1fEPZQ834Krk02faz5kPOrhkzjhUvznx9hZI227WYD/0CJmY0rp68LSi5GIx4tjtUnQVTl7iGBZN6cEIdWYJYEf/DMdQEfB7XO2r9lhW9v9gnmofiwwP+eZWwUYpF4fggju3rCUTbHrhRaKLVrsfBgK9V7LW6qVneoO0K3FIDO+WOJJj160ntl58o1ev0/ZVCtjeSKnzyAM0MeZfvbrmNsgl7qQQTGF3J6Jgf3WHWp4r+XUUGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: <Shivanand.Kunijadar@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>,
        <koshiro.onuki.h55@mail.toshiba>, <kazuhiro.hayashi.f74@mail.toshiba>,
        <michael.adler@siemens.com>, <christian.storm@siemens.com>
Subject: Re: [cip-dev] [isar-cip-core][RFC v1 0/7] Device onboarding with wfx
Thread-Topic: [cip-dev] [isar-cip-core][RFC v1 0/7] Device onboarding with wfx
Thread-Index: AQHcsEauMcBfZQhoj02juZJKF3ThALWyrnec
Date: Tue, 17 Mar 2026 12:15:43 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB9669CD1BDECBA17975539CEBC441A@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: <189B608C0492E7EB.2292097@lists.cip-project.org>
In-Reply-To: <189B608C0492E7EB.2292097@lists.cip-project.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|TYWPR01MB11940:EE_
x-ms-office365-filtering-correlation-id: 95e99729-4e1c-45ad-4fb3-08de841ee955
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|13003099007|8096899003|56012099003|22082099003|18002099003|7053199007|38070700021|95630200002;
x-microsoft-antispam-message-info: 
 +jMwDUbZoNFZIcmZM8Nio3L9Ki8wT7G9q6Gpeye1bBzX04oMSi6EYvQ/CiIukYzsNLBudXItwHqJbtlZYS/4PSUBGwxV3IODqj81ULFEQlcOCsNeM/2A7VZzjsJwMiMTqKKoRaPwFQkazIV0Grkp4gVsgQ1pJ+feQ5HIp01TpkGSAUV60VUx1DfIO3iFTc1cI5IXCJ4crpzZPukFKmL6EGJpv4Biu3NIMpY88hIT2GvOlTDy2MiKoqeb+PS692U1BDSiEO8zBVGiB7XTgYONPQuMVniIXtJwIXZbYvHh4qC8xmyxM7VM+GJQ1W7Tf0Yp7M75WWRDIFSBnPI1+Z7XweVVw/Eb9bGJXLT0fkUi23Ji4lV63lzalnNFHYAZm5C1xTGjIGbLmZI1TNl0n/4KmFsuz6SGRaR+zTLeNsDoRvDAvWwas+f0peP5LKCDEdA2k3Vn2NOn1BnV7V7C7I+Ep5pDg1JWmHNqfhNdVCqAPt8ybu9FDwqz0e1SpZ6i5+UF1JIxI7OS+qq4HPZJpEucpySdDhGHjTNLjpFnleXnvw5FSYerNeQFWBmp2gea3sYiQKRm7p6GLZTzm5SU5mB2kZtxWNedGlEkUxR7I256cVH8OSz9qLF85+VRzMqLsAyEjLRgmjcv0VXKbPu2OvL4ctzCVfehDSW8nMFLd31Ata4PfnE8ZlolgKxHt+YH22n8gK0WfiwFFNanBN/cTovC0RO7TZ5KqGhqVSxTjUGzbL9oFv/6+lqhK3XyEJIngGg/s0bVrka2f1TsUSrtcMZ/OIyVOYDNYiNhIiQ26BSq0ZJ9HlkKO5qgES9PteGJXQGQAV6KN47kl7ExeCc1RMo2MQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(8096899003)(56012099003)(22082099003)(18002099003)(7053199007)(38070700021)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?czZNU1hma29vMkdWSDJlU0RUWC9NQk41NXBENnE5THcwbXB3VzdIejkw?=
 =?iso-2022-jp?B?ajc1bkhncXhPeFNvUzkxWDBCVWRjUWlHak1vNVoxd05GMGlyZEFpaGFD?=
 =?iso-2022-jp?B?Vy9WVWIrQW1WQnJEYUZvaFNGd2lya3hlb1kvKzRJZ3RKdzFseTRnOHVh?=
 =?iso-2022-jp?B?NVB1VXk3QXA2VjRtb0Ntdjd1cytjVWxaQkw4QTVmNHdZUkE3YlJKN1Ix?=
 =?iso-2022-jp?B?NnJ5Y3drZFh5anZXaWxoc2RqUVdOM2pzMm8wVGRmUy9xcWROL1BkVStY?=
 =?iso-2022-jp?B?Vy9aakVTSnNZblVhWSs5UmpqMFhkaDdlTUt2eWlxUUZLVHVSdGx0aHZ2?=
 =?iso-2022-jp?B?THJwRUoxTjZjT1EzWjh2a2lVZVVLU0hnMDIxRTlzZmVObDhaWWYzcStZ?=
 =?iso-2022-jp?B?M2lxdi9wOHRxUVlqbUlMZjh1NnVOWVUraTNNRm94WThGZHZDdUVUemcy?=
 =?iso-2022-jp?B?eHJJZ2hFTnduYWFrdUR2TUVsUWpQNTdIWTFnbVZkbEhQeE4za0Zwd0JB?=
 =?iso-2022-jp?B?ajdEL2IwYnNQWGFIL0h2bkJvT2EyL0RPRnZJbTFpUDBwNlRxZDZhT3Vy?=
 =?iso-2022-jp?B?Z29EN0J4T1pBREVYTkFCako4eGwzVTZGa3c1UHlrQ3F4MDJaR3hqWVk4?=
 =?iso-2022-jp?B?Vkd2MjlxVkd4OXlPK1Y1b2ZoYlVYdUlBdC9Yc2k4YUdRLzg4d2xja0FK?=
 =?iso-2022-jp?B?aHhzKzBpUU82UjhUM0xGVjFNL3d1dTNLblVjalpSRFplRW1xcHJLaE5J?=
 =?iso-2022-jp?B?NkhSVm04VkNqdmRkWUxscS9Pa0ZQU1lXelR5L2xjOFVDYWhrYnVrU0JM?=
 =?iso-2022-jp?B?ZHNaRjV2d1BDa01iNlJDalpVZmpNdW9JMlpzNno2anQzSDc0RUpGU1ph?=
 =?iso-2022-jp?B?THFIZzc3TXdxTnUxTDVmVldYbHVBUXMya1NERVVHM3ZzNlpwdStrUGNV?=
 =?iso-2022-jp?B?RDNRY1hOT1BqaFhEb3lNZW9wV0xGbUViVGNYV3djaWVPbWN6cmp3RktJ?=
 =?iso-2022-jp?B?aCtlN1FOTFVSSWpGN2V6NkNZZFh1Mk9uakZET2xSK29nWVM5WFpESk5J?=
 =?iso-2022-jp?B?dmVLZndXdkt6VG13L0RNU1dMbXl3TVI0d3JVZkRvcy9pUDliTzlrVmhD?=
 =?iso-2022-jp?B?Nnd5NExqYnk2K3lJZTZzb2cwQXN3QWozQmlwNGtDWTRlN0pRNG5YUVJq?=
 =?iso-2022-jp?B?aVVEdEYxMm1BaTNFY3VQY1Y5VTFpWTFxQWJIVzhxWXNXZ0ptVGF1bkFB?=
 =?iso-2022-jp?B?MW5BWERuOUxZK20rNTNvYUpPTUlMd0xacTMwZThONjJSa0JLc0IrczFE?=
 =?iso-2022-jp?B?OU95THg0U3Vpdy80QXEyc3U4alVGUnlYYmJnZUswR3ZBR3drd0tiV28y?=
 =?iso-2022-jp?B?VVozL3R5Mko5VS9xbmk1eXB5M2YwMlZ4d0tJNUxzZUg5SUZpOW9GdEdz?=
 =?iso-2022-jp?B?SEY5QkFVM0FVWHFJc2laYjhVbzFJWEdDS0ZKT1ozdlo4dDBVckh6eFZj?=
 =?iso-2022-jp?B?ZzVYNHUxTFhrTkR4bnZJYm40ZE8rSTZpZWJwSjN5UWNEeFZnLzZrTVpm?=
 =?iso-2022-jp?B?Nnp2YmJKSXdTR0JBSjFpR25uVHhaY2RhZmFxVHFFZG56TUxJU2FaYnpl?=
 =?iso-2022-jp?B?eDh1QSsvMXN0QmdyUXFuL2JxNjJOYStCNUN5WUlHUnhrRm83N0oxL084?=
 =?iso-2022-jp?B?anpCdGhxTUJCdndvbnZabkp1YnA0YTRURkZ3TG1RZjFpQzZIMVlrM3Bn?=
 =?iso-2022-jp?B?cEZQRkxWb0xsaHpsNWRkNFpvaWtJSFNnWDJXWWhUVHdtc3Flelp0dmVS?=
 =?iso-2022-jp?B?YlE4VUFLR24yc09IbjZIL3A5RzQxRDUrWlo1VyszN1JBUUdOTGJGS3BB?=
 =?iso-2022-jp?B?WjA5YWxmdTV3cVFHNGxIWStSUHdlN3hwdk1NQ2kwaWtxSEpvbEw5eDcy?=
 =?iso-2022-jp?B?MzBSS2N3SlFoNWJpT01GcVhjTnMwdzUzaEJPNGFyMzZFa3I0aXFpQ1Qz?=
 =?iso-2022-jp?B?SDBYYTBDcHlHWEdDblpwUEZKZGkyQXBiUUYxQkdKL1UwQjVlWDBlcS9Y?=
 =?iso-2022-jp?B?YjNYbVBpbzNRQXVUOVphZWpnTzgra0FJc3ViTGhrVXp3eXQybkk0T1pu?=
 =?iso-2022-jp?B?T1FLeU12cHgxY3BxcForQ25Eb0kzNjVkWmtOOFVNdUdqbVliYWVCZU40?=
 =?iso-2022-jp?B?RHgwZGNJanYwK21CT2phNTJHYm9ISlJqc3ovcHV5KzdwNkZtT1puc2ha?=
 =?iso-2022-jp?B?T1c4MnRwVm9rQlZTUWZGZm9OM2hJanNwcVdLMFUycXpkU2gwTzhSZHUx?=
 =?iso-2022-jp?B?QnJwbWhaZGxMblE1NGZyY1ZSbnlmaVFhb3ZOeml0S2N6a3N0cVRtSlhF?=
 =?iso-2022-jp?B?UHhuU203NWluSDQwN09SM2VZbm50dkN0eHNtQUF0UXNHOHdscUd0bk8z?=
 =?iso-2022-jp?B?OUVudjM5MG1hOHdNaHE1QzFlMlg5NWhOU3FiNlB2cUhYWmpIbWs2OW1w?=
 =?iso-2022-jp?B?R1RoRUF3Q0g0M2psbkFtV21DWlFpTlpEbDI1RDJyT2N2OWdZaXlXYzkz?=
 =?iso-2022-jp?B?T1BjTWEzbz0=?=
Content-Type: multipart/alternative;
	boundary="_000_TYCPR01MB9669CD1BDECBA17975539CEBC441ATYCPR01MB9669jpnp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	I79h+u4w0DT1Qc/qxtReoaN8SFLYfup2CBcrq66uGyOqpKAJRS+rsTc80/+k0ohZgyZfDclJ8FmM54MToVmxns18efPSeQW6iKVOfxoiHj4/TBrEnVMTr6TsgihdVCef6qC6HdOQkIEj4Uet+hk5pLOSn2NC3bKuN48dc5YNnvgjYHF9RSuRC+LZdQ4diqnvzyudFq7UrgDjYV3i5u5H4zdnihtbKbZk20qaiWzdybeEUDb2brrCVioZ9rWq8teznC/VFnAEmO/ef/PHzJzdvO/ojTOcrsol3bGm0udQoIjoUGmfqC8EAZRLkBFjroMjTmK8821mEFt0qhDvciDtFw==
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e99729-4e1c-45ad-4fb3-08de841ee955
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 12:15:43.1556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wPEyaIfcehcOp+FUFYtweU6NpcnrBLFXROWdsr3qguRmsYTxs0eQjNYPTVvpAzGAUSun9XvN0hCAmGrpl3Sp44BbMSK6YkUnMNK+wyhsB7Ll1w5UthmYIoEXmj6MzMRN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11940
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 12:15:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22486

--_000_TYCPR01MB9669CD1BDECBA17975539CEBC441ATYCPR01MB9669jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi All,

Just a gentle reminder for some feedback on this patchset.

Thanks and Regards,
Adithya Balakumar
________________________________
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on beha=
lf of Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
Sent: Tuesday, March 10, 2026 10:00 AM
To: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>; jan.kisz=
ka@siemens.com <jan.kiszka@siemens.com>
Cc: balakumar adithya(=1B$B#T#S#I#P=1B(B =1B$B#D#I#T#C!2#D#I#T=1B(B-=1B$B#O=
#S#T=1B(B) <Adithya.Balakumar@toshiba-tsip.com>; kunijadar shivanand(=1B$B#=
T#S#I#P=1B(B DITC_DIT-OST) <Shivanand.Kunijadar@toshiba-tsip.com>; dinesh k=
umar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <dinesh.kumar@toshiba-tsip.com>; onuk=
i koshiro(=1B$BBgH4=1B(B =1B$B8v;JO/=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B) <ko=
shiro.onuki.h55@mail.toshiba>; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B=
 =1B$B""#D#I#T#C!{#C#P#T=1B(B) <kazuhiro.hayashi.f74@mail.toshiba>; michael=
.adler@siemens.com <michael.adler@siemens.com>; christian.storm@siemens.com=
 <christian.storm@siemens.com>
Subject: [cip-dev] [isar-cip-core][RFC v1 0/7] Device onboarding with wfx

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

Currently wfx does not handle device registry / onboarding. However, it pro=
vides a plugin system that allows to process
incoming HTTP requests before they are handed over to wfx's internal logic.=
 This can be leveraged to communicate with
external systems based on certain parameters in the http request.

CIP software update WG has created a simple implementation for this purpose=
 [1]. The concept includes wfx (running with a plugin)
and a device registry service running in the backend. This requires a few c=
ustomizations on the image side which is explained
by this patch series. This implementation is currently under the cip-playgr=
ound.

Here are some notes on how the current implementation works:
- The onboarding process is essentially a configuration update handled with=
 SWUpdate.
- The plugin only interecepts the request if the client ID is set as "onboa=
rding" and respond back without allowing the request to
reach wfx. Else it lets the request pass through to wfx.
- Creates a onboarding swu file with configuration file.
- Creates a DAU workflow instance (Job).
- Respond with Job ID for onboarding job to SWUpdate.
- SWUpdate queries for the job and installs the onboarding swu in the targe=
t.
- A custom progress client [2] listens to progress messages from the onboar=
ding job and triggers a restart swupdate in the activation step.
- The plugin requires signing keys for signing onboarding swu files. Suitab=
le keys as used on the client side must be available to the
plugin as well. Currently the plugin uses the snakeoil keys from Debian tri=
xie.

For now I send this as a RFC for a broader visibility to understand how thi=
s integration can be improved.

[1] https://gitlab.com/cip-playground/cip-wfx-onboarding-client-plugin
[2] https://gitlab.com/cip-playground/cip-wfx-onboarding-client-plugin/-/tr=
ee/master/onboarding-progress-client?ref_type=3Dheads

Adithya Balakumar (7):
  swupdate-config-wfx: Add the required configuration of wfx based
    onboarding
  wfx-onboarding-progress-client: Custom progress client for device
    onboarding with wfx
  swupdate-config: Add custom-http-headers section in swupdate.cfg
  SWUpdate: Use the backported package for trixie
  Kconfig: Add kas menu options for wfx based onboarding
  kas/opt/wfx.yml: Consolidate wfx options into a separate kas yml file
  doc/README.swupdate.md: Add information about wfx based onboarding
    function

 Kconfig                                       | 22 +++++++++
 conf/distro/cip-core-trixie.conf              |  3 ++
 conf/distro/debian-trixie-backports.list      |  1 +
 conf/distro/preferences.trixie-backports.conf | 11 +++++
 doc/README.swupdate.md                        | 46 +++++++++++++++++++
 kas/opt/wfx.yml                               | 22 +++++++++
 recipes-core/images/swupdate.inc              |  4 --
 .../files/suricatta_wfx_onboarding.conf.tmpl  | 10 ++++
 .../files/swupdate_override.conf              |  6 +++
 .../swupdate-config-wfx_0.1.bb                | 15 ++++--
 .../files/{swupdate.cfg =3D> swupdate.cfg.tmpl} |  2 +
 .../swupdate-config/swupdate-config_0.2.bb    | 18 ++++++--
 .../files/postinst                            |  4 ++
 .../wfx-onboarding-progress-client_0.1.bb     | 26 +++++++++++
 14 files changed, 179 insertions(+), 11 deletions(-)
 create mode 100644 conf/distro/debian-trixie-backports.list
 create mode 100644 conf/distro/preferences.trixie-backports.conf
 create mode 100644 kas/opt/wfx.yml
 create mode 100644 recipes-core/swupdate-config-wfx/files/suricatta_wfx_on=
boarding.conf.tmpl
 create mode 100644 recipes-core/swupdate-config-wfx/files/swupdate_overrid=
e.conf
 rename recipes-core/swupdate-config/files/{swupdate.cfg =3D> swupdate.cfg.=
tmpl} (73%)
 create mode 100644 recipes-core/wfx-onboarding-progress-client/files/posti=
nst
 create mode 100644 recipes-core/wfx-onboarding-progress-client/wfx-onboard=
ing-progress-client_0.1.bb

--
2.39.5



--_000_TYCPR01MB9669CD1BDECBA17975539CEBC441ATYCPR01MB9669jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hi All,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Just a gentle reminder for some feedback on this patchset.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Thanks and Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Adithya Balakumar</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-proje=
ct.org&gt; on behalf of Adithya Balakumar &lt;Adithya.Balakumar@toshiba-tsi=
p.com&gt;<br>
<b>Sent:</b>&nbsp;Tuesday, March 10, 2026 10:00 AM<br>
<b>To:</b>&nbsp;cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project=
.org&gt;; jan.kiszka@siemens.com &lt;jan.kiszka@siemens.com&gt;<br>
<b>Cc:</b>&nbsp;balakumar adithya(=1B$B#T#S#I#P=1B(B =1B$B#D#I#T#C!2#D#I#T=
=1B(B-=1B$B#O#S#T=1B(B) &lt;Adithya.Balakumar@toshiba-tsip.com&gt;; kunijad=
ar shivanand(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) &lt;Shivanand.Kunijadar@toshi=
ba-tsip.com&gt;; dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) &lt;dinesh.k=
umar@toshiba-tsip.com&gt;; onuki koshiro(=1B$BBgH4=1B(B =1B$B8v;JO/=1B(B =
=1B$B""#D#I#T#C!{#C#P#T=1B(B)
 &lt;koshiro.onuki.h55@mail.toshiba&gt;; hayashi kazuhiro(=1B$BNS=1B(B =1B$=
BOB9(=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B) &lt;kazuhiro.hayashi.f74@mail.tosh=
iba&gt;; michael.adler@siemens.com &lt;michael.adler@siemens.com&gt;; chris=
tian.storm@siemens.com &lt;christian.storm@siemens.com&gt;<br>
<b>Subject:</b>&nbsp;[cip-dev] [isar-cip-core][RFC v1 0/7] Device onboardin=
g with wfx </div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">From: Adithya Balakumar &lt;Adithya.Balakum=
ar@toshiba-tsip.com&gt;<br>
<br>
Currently wfx does not handle device registry / onboarding. However, it pro=
vides a plugin system that allows to process<br>
incoming HTTP requests before they are handed over to wfx's internal logic.=
 This can be leveraged to communicate with<br>
external systems based on certain parameters in the http request.<br>
<br>
CIP software update WG has created a simple implementation for this purpose=
 [1]. The concept includes wfx (running with a plugin)<br>
and a device registry service running in the backend. This requires a few c=
ustomizations on the image side which is explained<br>
by this patch series. This implementation is currently under the cip-playgr=
ound.<br>
<br>
Here are some notes on how the current implementation works:<br>
- The onboarding process is essentially a configuration update handled with=
 SWUpdate.<br>
- The plugin only interecepts the request if the client ID is set as &quot;=
onboarding&quot; and respond back without allowing the request to<br>
reach wfx. Else it lets the request pass through to wfx.<br>
- Creates a onboarding swu file with configuration file.<br>
- Creates a DAU workflow instance (Job).<br>
- Respond with Job ID for onboarding job to SWUpdate.<br>
- SWUpdate queries for the job and installs the onboarding swu in the targe=
t.<br>
- A custom progress client [2] listens to progress messages from the onboar=
ding job and triggers a restart swupdate in the activation step.<br>
- The plugin requires signing keys for signing onboarding swu files. Suitab=
le keys as used on the client side must be available to the<br>
plugin as well. Currently the plugin uses the snakeoil keys from Debian tri=
xie.<br>
<br>
For now I send this as a RFC for a broader visibility to understand how thi=
s integration can be improved.<br>
<br>
[1] <a data-auth=3D"NotApplicable" class=3D"OWAAutoLink" id=3D"OWA236306c3-=
4101-5456-fb1e-22118482be79" href=3D"https://gitlab.com/cip-playground/cip-=
wfx-onboarding-client-plugin">
https://gitlab.com/cip-playground/cip-wfx-onboarding-client-plugin</a><br>
[2] <a data-auth=3D"NotApplicable" class=3D"OWAAutoLink" id=3D"OWA7d994244-=
b600-9a7f-3f85-1cc5f5a8a609" href=3D"https://gitlab.com/cip-playground/cip-=
wfx-onboarding-client-plugin/-/tree/master/onboarding-progress-client?ref_t=
ype=3Dheads">
https://gitlab.com/cip-playground/cip-wfx-onboarding-client-plugin/-/tree/m=
aster/onboarding-progress-client?ref_type=3Dheads</a><br>
<br>
Adithya Balakumar (7):<br>
&nbsp; swupdate-config-wfx: Add the required configuration of wfx based<br>
&nbsp;&nbsp;&nbsp; onboarding<br>
&nbsp; wfx-onboarding-progress-client: Custom progress client for device<br=
>
&nbsp;&nbsp;&nbsp; onboarding with wfx<br>
&nbsp; swupdate-config: Add custom-http-headers section in swupdate.cfg<br>
&nbsp; SWUpdate: Use the backported package for trixie<br>
&nbsp; Kconfig: Add kas menu options for wfx based onboarding<br>
&nbsp; kas/opt/wfx.yml: Consolidate wfx options into a separate kas yml fil=
e<br>
&nbsp; doc/README.swupdate.md: Add information about wfx based onboarding<b=
r>
&nbsp;&nbsp;&nbsp; function<br>
<br>
&nbsp;Kconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; | 22 +++++++++<br>
&nbsp;conf/distro/cip-core-trixie.conf&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 ++<br>
&nbsp;conf/distro/debian-trixie-backports.list&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 1 +<br>
&nbsp;conf/distro/preferences.trixie-backports.conf | 11 +++++<br>
&nbsp;doc/README.swupdate.md&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; | 46 +++++++++++++++++++<br>
&nbsp;kas/opt/wfx.yml&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 22 +++++++++<br>
&nbsp;recipes-core/images/swupdate.inc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 --<br>
&nbsp;.../files/suricatta_wfx_onboarding.conf.tmpl&nbsp; | 10 ++++<br>
&nbsp;.../files/swupdate_override.conf&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 6 +++<br>
&nbsp;.../swupdate-config-wfx_0.1.bb&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 15 ++++--<br>
&nbsp;.../files/{swupdate.cfg =3D&gt; swupdate.cfg.tmpl} |&nbsp; 2 +<br>
&nbsp;.../swupdate-config/swupdate-config_0.2.bb&nbsp;&nbsp;&nbsp; | 18 +++=
+++--<br>
&nbsp;.../files/postinst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 ++<br>
&nbsp;.../wfx-onboarding-progress-client_0.1.bb&nbsp;&nbsp;&nbsp;&nbsp; | 2=
6 +++++++++++<br>
&nbsp;14 files changed, 179 insertions(+), 11 deletions(-)<br>
&nbsp;create mode 100644 conf/distro/debian-trixie-backports.list<br>
&nbsp;create mode 100644 conf/distro/preferences.trixie-backports.conf<br>
&nbsp;create mode 100644 kas/opt/wfx.yml<br>
&nbsp;create mode 100644 recipes-core/swupdate-config-wfx/files/suricatta_w=
fx_onboarding.conf.tmpl<br>
&nbsp;create mode 100644 recipes-core/swupdate-config-wfx/files/swupdate_ov=
erride.conf<br>
&nbsp;rename recipes-core/swupdate-config/files/{swupdate.cfg =3D&gt; swupd=
ate.cfg.tmpl} (73%)<br>
&nbsp;create mode 100644 recipes-core/wfx-onboarding-progress-client/files/=
postinst<br>
&nbsp;create mode 100644 recipes-core/wfx-onboarding-progress-client/wfx-on=
boarding-progress-client_0.1.bb<br>
<br>
--<br>
2.39.5<br>
<br>
<br>
</div>
</body>
</html>

--_000_TYCPR01MB9669CD1BDECBA17975539CEBC441ATYCPR01MB9669jpnp_--


