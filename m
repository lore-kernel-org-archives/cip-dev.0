Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2FFCCF9E9
	for <webhook@archiver.kernel.org>; Wed, 29 Oct 2025 04:45:44 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web01.967.1761713140217243980
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Oct 2025 21:45:40 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 59T4jbao671890; Wed, 29 Oct 2025 13:45:37 +0900
X-Iguazu-Qid: 2yAbc3FhhpIXyJ4Brn
X-Iguazu-QSIG: v=2; s=0; t=1761713137; q=2yAbc3FhhpIXyJ4Brn; m=iqw2HfxmahKIiZPJYi9JfLutbUochMz/V7eH9WV+UXI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cxF6n0CSXz1xnk; Wed, 29 Oct 2025 13:45:36 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqx8liMXi2l6HXzbQ369mgXkfJBoWIlX9IK1KjH8EjWWDs4o+mcFOql8sWwhVU0w8TjZLwvPfMYef3iw3OJzP8Qm2uaZhsIMFKcmiBkIZ8B5Mvu9jgnvg7EzksyiHGDFHR4jqvJplohy9yB8s8Mao+iVfQ/rkVtXn6FdOeRv+B3zkm4DBzEjLKNsKHWHHVGHERMaJeUf6zClP3sA92lIrvT13WXTclQAeX68sG5e8gsh1hSbHdDufFPFznoaWYcWCoe9s76iYUHnlMYG0C4mIw4oKYv55o3/saJ5H3dRnKJlYfCMOb3pI/hTF6x6hJEMgi/3mRucbwbVbMhkI6C30g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58dS0h6Cjdgf8FhGT1Xn+jsal8W3AiPIgYBPnjAJOGs=;
 b=fziY8mkYUqRZJZmrp8OGkkgYrKuIXg0dXZQkOA5PJCGG+1oadHmAIuE8JYj1KC0Cdr4zFEs44HBMTOenvLKkn//AcTloZ5ByEd7AJPX+d3PLv91+rcYN85h9Vr/lYush80/vf7XsiHUwn2qxs9t4RpBXlAeEdV+w5qRKmBRC1Nd92EHoUKZokrc3k5pckZ9DA9ME8GuZiCzhqJSB5uc/dYThndxE0fS4K2DGLU7A0lq+1hIFw4oLdTsND3NXDyn31t5FxuUob3jtA88RMgb7WebRvgqYIqMM0/WZ6vlAb4iUIrrQfEY+GeI2WUPAQCtyykr4A9g1iccQdhZSCEe5/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: <Shivanand.Kunijadar@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>,
        <kazuhiro.hayashi.f74@mail.toshiba>,
        <akunuri.sahithi@toshiba-tsip.com>
Subject: Re: [cip-dev] [isar-cip-core][RFC v3 1/5] SWUpdate: Use self-built
 SWUpdate 2025.05+dfsg-3 for trixie
Thread-Topic: [cip-dev] [isar-cip-core][RFC v3 1/5] SWUpdate: Use self-built
 SWUpdate 2025.05+dfsg-3 for trixie
Thread-Index: AQHcSAOlYnzMADZBWk6T047ODoNDs7TXqkEAgADgmCs=
Date: Wed, 29 Oct 2025 04:45:33 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB9669F78EC1C4E72B6746B3C1C4FAA@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: <20251028122042.2355451-1-Adithya.Balakumar@toshiba-tsip.com>
 <20251028122042.2355451-2-Adithya.Balakumar@toshiba-tsip.com>
 <fd2e7753-be26-4202-8e8f-ce206a359188@siemens.com>
In-Reply-To: <fd2e7753-be26-4202-8e8f-ce206a359188@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|OS9PR01MB16184:EE_
x-ms-office365-filtering-correlation-id: 0df07ff2-017b-4caa-90ad-08de16a5fed5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?QXJ6Q3ZwTW4yN2NjVnRPWnVJUWVwOWRoWGxxbEswYXZEMVU0VHp2NElS?=
 =?iso-2022-jp?B?T3B1UjVkaGUrYjBLSGh4R1Y2K0JmTUsrS2Qzd0tGNWdscFVHcWl6Y3dH?=
 =?iso-2022-jp?B?NmQ0eDcvSUc3NWFwUGlQQkt5RG54MlJFV0s4SzVwOXdHQk0xbzJhSXZ6?=
 =?iso-2022-jp?B?V2lueUhxL0JScCtSblJnSmx4Qm0weGIvSlhSa3VQWjRVTXI2b3Z0SkNK?=
 =?iso-2022-jp?B?K3Y1a0tzNTBlWkRVQUp6WTFsNTNUVWhGQ1c1bDVsT3RlV1hMalBPZmhO?=
 =?iso-2022-jp?B?MDdxZTRiN3h0MFRFSVlMYXF1emxUYnlycm9pMzZHbVp0a2dtYUx1VkVo?=
 =?iso-2022-jp?B?eG90dEV0aEV6WTFMQ09oZDgzQnFKYWZFNThUN2FEeklSUzdOY1VvbHNG?=
 =?iso-2022-jp?B?eTZ4NzNNaENWRGxSdExlUDdHQ0FRekp0N3RBWWZEMC9CYlliYS80c0N1?=
 =?iso-2022-jp?B?WEdTOXU0VkxLZ1M0WGlEWUQ5ZXlvMk45cGx0NHROdnhncEcrblUwbC9U?=
 =?iso-2022-jp?B?d2I2akZLbURrQ2crbTFSOGt1K2pUeUpNRGxHU1huYUkxTjJKWEx5K2lQ?=
 =?iso-2022-jp?B?dHd5ZTBYajlZdlJoeCtiQ2NUZTJiVitMYkZxRzZQMWJ2NXduYkNmalRw?=
 =?iso-2022-jp?B?RDBZYzEzMHl4RmYrYXNieHVoL29YRkRuU3Vob3VkRGpzY3hqT3N6Z1o2?=
 =?iso-2022-jp?B?WkROQVpPdFF4bGFXQytuY0QwVmlTMW16cXFxd284NDdMV2JaQXArS2JG?=
 =?iso-2022-jp?B?VFZVNzJyNnl1RHNnTEZwZWhUNFhMV2RQR1JDNDZEK05SSUtWY0pDQWll?=
 =?iso-2022-jp?B?U0NlLzRjc1BsSndEeXNzemtKc3lSb0hpYnkwU1N6T1A5MEIyZXhOQWMy?=
 =?iso-2022-jp?B?OW5Hb2t1NjBteEJJSmRXRCtBVnY0UHRpZ25CR1NyMjF5UzZyYXZUWG9L?=
 =?iso-2022-jp?B?Z0ozQ1l3anBMM0xxT20rOWFQMWRmSVNBbzI3aktwS0ZTM29wSDhDSXA3?=
 =?iso-2022-jp?B?ckdQa1lkL2wxdFdNcGNDOXVqMStkUnRhTXo3cG5kREFtaTFCallyVm9H?=
 =?iso-2022-jp?B?V2tCT0RUR0YrcnJuSnhtdVZpTXJaaGRobEtNR2xnZUxFcnY1Z2dlWWYr?=
 =?iso-2022-jp?B?NmFyL0t0WS9ER3JWRitxS3lrL0NzQ1hVZEczNm9uSU5RMGdxUiszb1R3?=
 =?iso-2022-jp?B?RkV3VXVpaVNZMU9xaENvRHl6N1AxZmNtTHBCcmFkWEQweVNzN1E5OTBu?=
 =?iso-2022-jp?B?UENNZVZDSElyNEplMDhOc3pHc1IwMVo5anZmS241T0tJbWNzYUc0V09I?=
 =?iso-2022-jp?B?eERsc2JSZzFSZDFoSXZSUml0citqVmhmU0cwTXg3OGc5UEYrM21xUVlX?=
 =?iso-2022-jp?B?djVhM2k1aCtLYjl4dklRVm9nYWJtN3lUSUdOajRrWkQ2Qjg2OXNVYUt1?=
 =?iso-2022-jp?B?MDdkOExSSW9PS2V6b0dJbW5Obyt6RHNrRHFaekhkZ2Rvc2JsQy9aQlE0?=
 =?iso-2022-jp?B?eGhZMHFQd1RsaGhFVmI2R1pCZTNZa0ZQNS9wT1JCRzZYbThOT3lrUDBp?=
 =?iso-2022-jp?B?NTVxWnIzMXBpV1FIV1c0RVpzZHByanBpUXorS0QzR2JVZmVpYmNsbGEv?=
 =?iso-2022-jp?B?a3RqQ0lrSnNZVW5jSWdFOXh3VnlIR1BkaUlLVGZDbW9BZHp5bEh5SjRP?=
 =?iso-2022-jp?B?MXJUd0E5NUp4Z21pRk9oVk5JcENDS1FTQ2lYN0hVYzZERndja0N2eVQ4?=
 =?iso-2022-jp?B?MUlvV0llbDJwUk42RE5WRXFiYzNBL25CeUR1Y3F3MkRvL3lWYm5adS80?=
 =?iso-2022-jp?B?S3lMMlhnVVRISXRIanM2QW93ckxtTEh2eFBNYTJJd0ZMMDZWNEdhZmFQ?=
 =?iso-2022-jp?B?cXNuMG0xbHBIY1Y0RWVaYUo0T3hORHdxZFcyanJTcFVJdnN1Tk15aXA0?=
 =?iso-2022-jp?B?OWVIMDFLOWl6TXcydjBZSmZvSlhENlo5T3RwTlQxd1VqYmJ4d2VuOHZx?=
 =?iso-2022-jp?B?MzVFZENmL2M5VWVXdXNCZ003YTFyOEpTbmhDYUc5em1Lb2lSZWg1QnV4?=
 =?iso-2022-jp?B?VXdoMkdPQTB4Mm9VRC82eWR5SFBacXBDV3dINDc5UytncTZET2EzaGtS?=
 =?iso-2022-jp?B?MUdGUENUMWpUQW1hblkvdzFVYWVCZzhmMWdjRnkvTlVPbC9kZ2p2Ymw0?=
 =?iso-2022-jp?B?YWNWVlovZkd3Y3A4ckQxVGdkZjd0eDVWSUEyeEJML1R2QU1wZDlyTE9P?=
 =?iso-2022-jp?B?TkovRE9IL1pJYlJaOUhFVTBrc3lPZTk5WT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Y3RFMWwySTJNRkRrNCsvODJoQXJUYU5OQ3lWY1R4bEFtbUdwRjZNVVRB?=
 =?iso-2022-jp?B?akdpeUNYWXBoL2NnSndudVAwUXNhb1RzTnBNellBN0o0djF6a25KNXVm?=
 =?iso-2022-jp?B?NmlLbW8vbWxTK3JGVklJTDJEelhJYkxkc3A2VDV4bndFS3AzVDJraFAr?=
 =?iso-2022-jp?B?bWoxbHlwMnphSnhWdWx4a3B2RkREZkk0S3pWVTRlVktWRmthVjFmV2E2?=
 =?iso-2022-jp?B?dmJJK1d5emFleWhFdGtRVzFlWUtiZDR3N1pFU2lQNXdXejhMVGtiVlJ3?=
 =?iso-2022-jp?B?UXJWa3B1MnZBQ29WckhDYURPNE9qY3FkeHhTaWozaVI0N2M1MW9Wckdr?=
 =?iso-2022-jp?B?aWNJN3pYR1lEQ3gxcU1yd1Jic3VxdWh3dTNNWXVDWlR2ZzZ6ZStaMVpx?=
 =?iso-2022-jp?B?R0ZUSmpSSDdseW10VGg5V0Z1YU13V3gxQzQwS1ZBbmxzaEJobFJtTldB?=
 =?iso-2022-jp?B?bWFtSzFwbDVPV0p2V20wVGV3VmlwaXE2dTU1bERzSGVsVGs0UTN2Ymxa?=
 =?iso-2022-jp?B?b1pWcDVWVTdHcy9vc09nR3hRaGZBcWV4SFlYZmlKU3RKcnAvUWRlWGtt?=
 =?iso-2022-jp?B?LzFtakptSktXcHJET09oY1lTRXhUaEdYd255WE5EdGZTOUc3L2dOVXgz?=
 =?iso-2022-jp?B?cVVZVU1jM3RqcXphNFVXem43TUtvYW9ERGg0S2w2Q3lyZTJKZy9JSzRj?=
 =?iso-2022-jp?B?WWlCbUZ0TVF0c0pINGxVaHpxcVFvMVZ2b0tNM0VoOTNiTVdxSGlUWjBF?=
 =?iso-2022-jp?B?WXEzTjhxbE5DeWNra3RKUmZMU2xYL1pFdENGaXRHSkhaZXNpcEdnWFdi?=
 =?iso-2022-jp?B?WXhWMGtTc29vYUZBTGJwVk5Rc3YxQXRVb01NdXhyNkJlTzVmWFJxT2p2?=
 =?iso-2022-jp?B?WHErZ0xPemJVV01NUWtzenBYMlZHZkdhUzB2ZWVLdTBRcnlPd2paZktS?=
 =?iso-2022-jp?B?NFQyTFBrSzFmUGR6bzZQQytRS0crRG9xTVFnZS9vdWpWM1hoR0p1aE9q?=
 =?iso-2022-jp?B?bjF0VDVoTkZHeDYremg2Rkc1WUpocWVLUndyQzZaVC8vNTNuOXFhdjFw?=
 =?iso-2022-jp?B?RjU0Y2hGVkQ5b0p5ZHRleVcxMDhyN1VEemRRSm5pcDByVTd0bytzZEpX?=
 =?iso-2022-jp?B?SjlmRFYrUmhBSVN0c21iSWxIN0x6RmJBN0U4bDdTdE1EaXBGdnFJZDd5?=
 =?iso-2022-jp?B?a1NITjJicmN5STNSRjJSeTdnc1ZyUUZsZnk2ZEtVdVM4QUxoRE1lNGI3?=
 =?iso-2022-jp?B?MEx6MEc3YUZGVlRuOHRpMVpPUG5yaGhuQmJLdncwUGdSQlNhWkpPeHBi?=
 =?iso-2022-jp?B?eDlGVjlZbHVYSjVpSGxRRmRIQ0NjeW9WUEtrN1FTbXJUMXFGVk11ZGU3?=
 =?iso-2022-jp?B?UmNUVCtiZmdsZFpQbWw4WlZ4cWpqSFR0dkluaXJTMENkVkx4cDVYc3FH?=
 =?iso-2022-jp?B?ck01c1oxSDlZYnpKRWxQYnFYRHFEYlJjZUFNSmhDN1EyZjIrb1A0RDZV?=
 =?iso-2022-jp?B?cTY0RjI3T2NtbGQ1bHhtUlovcGhvRGw3MHA0Z0FwTUpTSTNMS0FlSkVl?=
 =?iso-2022-jp?B?Q1d2dVZZUCtXNWQ1R25yMUczVFYxWFZWT0JFMkhYMytiM3hpMTNMQ2lO?=
 =?iso-2022-jp?B?Q3VBN2RaMm52R2x1UkZGL0ZRNFdjK1pWUkN0dmMramJzTFloU3ZGbHhs?=
 =?iso-2022-jp?B?VVZoMGlXOTQzSkxPb2wxc3VPRmdQeXFBWFcwUWJGU2JqVjVLOXJkaGFZ?=
 =?iso-2022-jp?B?SDJjYWxjODJiVDBjdXorcjMrSTE3cDE2TXBST1hlRFNtT1BSYU5RMW1G?=
 =?iso-2022-jp?B?M3diVzl1MTRrVDYzUDl3STcyN0lXV0ZPVHVwRmFTeXYrdm10eEFrTURK?=
 =?iso-2022-jp?B?OThSL3M0L2JKNkc4L3dUQlR2NmkyTUNlVCtMZlBGRWFGMU5GZ1JKc0JT?=
 =?iso-2022-jp?B?YmQ1WVlHeUlyZjAzWHphQlc1d2xmNWJ3MDRqMmZKc2YxTEkxb0pYK2pR?=
 =?iso-2022-jp?B?czYwQ3hvSkthUmZmdWVjNnhJbDhadzRnWHlvOXVJSGU4UzZSRUdZbGJQ?=
 =?iso-2022-jp?B?b0xRY09IU0JNSGRGV1FlTzdpVEVMRlFabzVaRmdoek12YkFCU2pTWURp?=
 =?iso-2022-jp?B?U0VicnB1d3ZTZFlKSzVwK1c3eTJvZW5KY1BGWDJsQm1sUzgvdFkxNXpL?=
 =?iso-2022-jp?B?MysvV2V3aEpZaCtFYjRFNWlGdXpvMnJ1cWcyTU50V2VTQjJsNkIvTE9X?=
 =?iso-2022-jp?B?WkxBcUJhZ2pmODM0VjhmM3pTMUVlTzc4UzRwcThoVm1wenI1TWVyNjVh?=
 =?iso-2022-jp?B?d25qMXhMQ2dRNTJRK1N6aDNuRnVOZmVBQ3c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df07ff2-017b-4caa-90ad-08de16a5fed5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 04:45:33.3354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: siyaCNg1EyI0lCGIYEMuCe0AduC+HaUj21e1WIktX130rS5l6ZbcOqIASYLNdtU/dEH08cOEojj8LrXED5T0l2q1S8bPYk0Mz7Kv1jAcT4vuZZQbgDpH9tXjidIrF3KU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16184
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Oct 2025 04:45:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20268

Hi Jan,=0A=
=0A=
Thanks for all the feedback on the series. Will address all the feedback an=
d send out v4 soon.=0A=
=0A=
>You have read Quirin's email that this will likely come via a trixie=0A=
>update? Let's give this path a chance first.=0A=
=0A=
Yes, I'll wait for a trixie update (as initiated by Quirin).=0A=
Apologies, I only noticed Quirin's mail to Bastian after I sent out v3.=0A=
=0A=
Regards,=0A=
Adithya Balakumar=


