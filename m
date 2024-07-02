Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79118C30658
	for <webhook@archiver.kernel.org>; Tue,  2 Jul 2024 06:46:57 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.18454.1719902809770968862
 for <cip-dev@lists.cip-project.org>;
 Mon, 01 Jul 2024 23:46:50 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 4626klQf781726; Tue, 2 Jul 2024 15:46:48 +0900
X-Iguazu-Qid: 2yAaySvebigj3G33sP
X-Iguazu-QSIG: v=2; s=0; t=1719902807; q=2yAaySvebigj3G33sP; m=cbEfp8k72dQCKqTHIK0Kr3/iGpPE6PaFeV+nDpG3jF4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 4626kkT41767869
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 2 Jul 2024 15:46:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SN7sXbVdD4Lil4Cw7iK1ZpGsOgyyTbpdQqkewiyBeAyF8s2MPj6w07gI/tO/Wx5q3qpPb+o10tGUom5uwlsPWr8TRo9rqvPrZC6hTDyf2l1hD48nq7AudTc8XA4bmVS5iIRb2opoagNqJ+5+F22IDKNKO8+fDcCRe1K6cgQjz2IsWvB9jACGUcuLKahdKB8IgA6psrkWHpDmoZX00ub+ZM2tRQuRtFQW+zdebXNpCe8hEAX6MuWKS1Jzn0UOnMrRO+5DUBI5K8ILqP4teZ3fi+rJCMozJJITog5zX92ZqoWQejQPPlOe033cX0By1lX5mZG8vWqIq9ufpuia7xI4ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhN8jToZP+a1rjjfBmcK+ycX+b8VBz5LWhztyhXUDBA=;
 b=HKiVHkag2SFR6OvVHb2IyjYNMORsfzfQzO5RLESG9bAo1hF0oQqa1YZoeo8xKjFxIv0Nil+lxEYpfcEsN7eIW3/vblkXFheLNOszPflbu5FDpPmlwyn8OoWDI0GSpDmbI73nCs0uE1j7LpZjc4Fh4Mz7ioCc0RcodO09FzBorv+SONRqx8UD0Sc3vLQC381HEo5w+Kvo5Ydxb5rV4U+KczHwenoY3w/9KHqKlIVuKLkO3DB84IL1SjMMdp0N7jFwWJxRrGR0fJPdMR6J1udyV7UnxuO3GGJu7SbTQVOv3DA8DoHUn2DiQQ/AporoMLB/QSZlTXB6UqcXyVAityMmtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <christian.storm@siemens.com>
CC: <cip-dev@lists.cip-project.org>, <dinesh.kumar@toshiba-tsip.com>,
        <Shivanand.Kunijadar@toshiba-tsip.com>,
        <Sai.Sathujoda@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <jan.kiszka@siemens.com>
Subject: RE: [cip-dev] Regarding support for WFX backend for software updates
 in CIP Images
Thread-Topic: [cip-dev] Regarding support for WFX backend for software updates
 in CIP Images
Thread-Index: AdrC1ksCFU48h0ptQR+cT3Q7rfn9dAALvlaAAS1PbFAAEtUdAAERYfYQ
Date: Tue, 2 Jul 2024 06:46:43 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB96699778EBAC2E3FA6E11FF4C4DC2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: 
 <TYCPR01MB9669288BB5107DAC76CE3DF7C4C82@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <561f6fd4-a66f-40a3-adb4-b94eb2c35ce0@siemens.com>
 <TYCPR01MB9669740DA683EAE4C6E8ADBFC4D62@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <6FC4E265-2F94-4144-A714-784FAC157CBD@siemens.com>
In-Reply-To: <6FC4E265-2F94-4144-A714-784FAC157CBD@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|OS3PR01MB9577:EE_
x-ms-office365-filtering-correlation-id: 6ba5db79-9e66-48ae-e21e-08dc9a62bc7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?dGJoZnVRT09ZYjhRTE1DdjhCRWVqaGx3ZkVGSGRnNVZWbXdMUXVFNHJh?=
 =?iso-2022-jp?B?ZTZEd09pSk9kcWRRTXhaaXhnY1gyUVFwc1kyRUNYMk1jMEduSEw3Mkpl?=
 =?iso-2022-jp?B?OE9CVytjenhBMVFsWDV5ZUh0a3RQMFk0bjk0Qy9PMElRbzA0Wm5maWtO?=
 =?iso-2022-jp?B?TkF2cjFRb2EwYUh2THQwMjMzWCtISkx2M0N0UVJqUzFCVmhZUXdXTTEr?=
 =?iso-2022-jp?B?YUZTYVFORTdBb0hkQ3VhUmc4TEYwQnA3aWhLRDNzN1ZJWFYxeGVUUWNV?=
 =?iso-2022-jp?B?aEVPZGlVRlg3UVpNQm1JQmdKeXNWdHlUaUpSV1Q4bXhqcjBFdi9ZYUVs?=
 =?iso-2022-jp?B?OEJFcW81ZUZsOWVPVWlCWC81T3I0UE1adUxoSzhRc25UbWlVMlZEQURu?=
 =?iso-2022-jp?B?U3l5L0I4UURKR1hYOXJLM2JrSUV6Z2xPaEhXcmhOcVJndUNkeW5tYllW?=
 =?iso-2022-jp?B?b1UxSVpob2IvcWlQcGNBTFRoTitaeE04VXY0dlM0eUN3Q000VDRzOXk0?=
 =?iso-2022-jp?B?eWxuVzVVK2lNZ0xhVXo4Q0hJSFR3ay90dWJNSDdBQlRZNy9mUm5OOXkv?=
 =?iso-2022-jp?B?OXMxTFk0L3BJL1I0dEJhV1JvdGhZcDUwdWtqWm13aHlGMkRSZWRubGJt?=
 =?iso-2022-jp?B?UzkyWm9RQW5kaU5uWjRtQjNaKzRuYVNLVUJHWjVqR2d3V2NUQ0ZVcFR0?=
 =?iso-2022-jp?B?OGVZamxmUkphS1l1SzNIZnkvSDBVdHo5ek95eWZjbmpXSGxicnVaYys1?=
 =?iso-2022-jp?B?VStKcWxTZEgzSGIwdHdweEtzbSthOStrK1kybXVtZEttYVVWay9Wb3VN?=
 =?iso-2022-jp?B?U3FQck9QVVFRTWRRaVJ1ejNPVWp6SmhBVzhJeU9PTlU3dDdkK2g4Q2JB?=
 =?iso-2022-jp?B?M1BLdU96QWxDWHJaczBWS2U0NHBudDloWSsyMC9xWDJHWGlTUkVHZ281?=
 =?iso-2022-jp?B?VjR5c1hCbk1jSmJ4eWhTbzJvVjN1NWdEcnlPWHdsWkZuLytyVjU0bjVv?=
 =?iso-2022-jp?B?M096dFc4MDdRL3hpMUg0dUF1TWdPNGxwamtpc0E0UXZzM1Vkdk9HNkNz?=
 =?iso-2022-jp?B?Y0RwUStZK2R2eXMyU2I5L0toZE5QY1NSckFiREluaVRFV2FRV0ZlbnBE?=
 =?iso-2022-jp?B?UnBtZzZ5YWo5T3BQcDE1MENCa285NnczdmxoZkV0RmxVZ3g0ZnRPUS8x?=
 =?iso-2022-jp?B?aG96eS9VYXY4Ync1aFlwcEZhK3Q5anpTS2wzaEtJME9RNGhQeFFTMEcx?=
 =?iso-2022-jp?B?N1RwaVFXU3FZR1pBNjRKaEJIRGI2UlZZVW5RNmlrNDdNamsyMzZyMmZS?=
 =?iso-2022-jp?B?OGVsMVRTNGZ0NkFKdUxpMnNWTUptTWpzSFB5NWFiamthRDIydzAvSHBF?=
 =?iso-2022-jp?B?V0l0ekpDZ09EZFZhOVNncS9IUDFlMktqYTFwMllBeWFDb0xnVHBldFk4?=
 =?iso-2022-jp?B?TjVvelBJeVZWMm9hUjJvUHFCN25VN0k1bDRrVFZWcVc4cTVIOWU3ZHhQ?=
 =?iso-2022-jp?B?VTBvRHNSRXlBWjd5QU10VEU3N2RKWVVZZW9HdkVKMDgyMzNRN2JvOTh2?=
 =?iso-2022-jp?B?WFljRC9ZbktZN202d1pEb3huWksvMlZXSWIrakgvNjJCSjZlVzlNWFE2?=
 =?iso-2022-jp?B?WEpFS01NSS9oakY0QkhSMTY5QjB2b0VhdHhPYVQzM2JWOXNkczdiYVZT?=
 =?iso-2022-jp?B?MHpwNG1JTlVzZXpjNGZneGlrZGZ1ZExvb1NPMjdybG5MMitObGxmS1Bn?=
 =?iso-2022-jp?B?MWlvTy9WMmpYWVBHbzkxbm85dDRDV01jc2lVN05iMXM0T25IWXpkeVl3?=
 =?iso-2022-jp?B?WElaVTdhaTVEQlEyN2ZXamt3aEoxMDE2ejBJOGIxUWtRMUVYUmd4MjV6?=
 =?iso-2022-jp?B?ay9uN1MyaW5YaUwwM3ZGSVNobEE3c21xUERsVTFJQ1p4aGpWeE1ranp3?=
 =?iso-2022-jp?B?WmpOaGtzU2gzQ1czckRIOWdITWlyQjVuU1V3WnloMzZwdExaZFAzb0No?=
 =?iso-2022-jp?B?ODdjRXlTR3htdFlmNHd2VGcyK0x1YVVvMENYdjlVSkg0NXdOMnhPRzRi?=
 =?iso-2022-jp?B?VlE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?T0tUYU1zN1N3L3BTc2w5UFZRVXM5T1ExMWlFV2hVeVdjbUhMSWNIaWdR?=
 =?iso-2022-jp?B?VHZadE83NU15M1R6Ym15VU9xdUhGb3BKZmExNDZIVy9XeUpENmpPVXVl?=
 =?iso-2022-jp?B?UDRJRkczQjd3WXlJeEduazltbURrczE4RVZaVlVDV3hhenVQd05lNXlm?=
 =?iso-2022-jp?B?VENyeEM3VnBUV0UwZmVQSFlkb2ZlQXZMRmc0NmpDZndPbnR2a1g5ZE9z?=
 =?iso-2022-jp?B?dWNTNEdVMkZsVVNmYTduendkbFVNUWxkWjcrWmg0QXNPdkVBYThlM0JR?=
 =?iso-2022-jp?B?Q0ZvVkkwQTJwZzZvbEFDWE13d1krYUJTaURsWi9EdWhNbmRnb1pHbVpl?=
 =?iso-2022-jp?B?enBYS0xpZVIxcm9PUDI4UDRYTC9aK0lwSmt2a1RGRnJHY0NobzlFUUZv?=
 =?iso-2022-jp?B?ckhNb3dpQ1AzYTRHRTlZNC9VSUdHRkd1SVIxRXA0bER6eGwvSllHSmdr?=
 =?iso-2022-jp?B?bVF2d2Jnanp4ckRBTm9CbFJXeVpINHUwbWgzSzh3eGNESVhvQTc2VlRK?=
 =?iso-2022-jp?B?RW5wdlVZUEFZeXpjKzhuUTh5K1J5b0lIVGVtSUZYRlBSUUtpSFhNVjc2?=
 =?iso-2022-jp?B?Snk5VE9pdE5LRllTVEg5RlFpdTdvTHhkdUJtQUoySFZhZGlDQVJiTTVN?=
 =?iso-2022-jp?B?K0xUV0tWc2RUbjlyTjdjUXBnRFhJL1BxSys0UGRqVlNJWDhzb1NpeWtT?=
 =?iso-2022-jp?B?dERNRWhqMzlVN2xBTnhZTEovaXhpYXJERW9PV2RoMGNncWRPTFE5N1dL?=
 =?iso-2022-jp?B?ZE8rK2ZOZXR3cTVObmlVc1dFOE1UYkRWcUNDWTVsY3dIL2Z1K3lRcEhk?=
 =?iso-2022-jp?B?M21zcEkyQi9vMWxHTEE5YzVGMlA0RkZxaE5kaUlJVjN5S1Q4OWNYNDZG?=
 =?iso-2022-jp?B?eXVXS25iVU5Vby9Sbmp2QnRTREFScHNQMTM4SHB6UXdPaGtKYVhoeDNv?=
 =?iso-2022-jp?B?UGRJMlZ5ZysyanJQUFFxQUR2Vk1iWlVJekx1UlNoUEhRZXlUVDYyL0VT?=
 =?iso-2022-jp?B?Wm5Sa0V4WjVuWVErZVdITW5KZFVGUk04ZFBUMC82OGxneUlvd1hXL3pq?=
 =?iso-2022-jp?B?SWc5OFhsMk1GQ1VpaE9DZXkvbm5oZUo3YVUzQTExUGZNSk5xS2NpR3cy?=
 =?iso-2022-jp?B?T0hTWTlMYTBPcndvZXczZEZKb2V2VjR0UFhxNVJMeEdMT2RJQ2lJbDZC?=
 =?iso-2022-jp?B?QmNJVW12b0JPZVBZV1NaUjFMZlBxVWNzbDlWNXphd0lRNjhnNW5xR0t6?=
 =?iso-2022-jp?B?K2RMTUdwUE5RR3U0aEpwSGl3eGxPeHo4bVF6YkZ5SnpVZml5SFNuZmY2?=
 =?iso-2022-jp?B?eHVvdDJLOHRqNWRJUlgzOS9hQ3dDemRGZUxRV0Q4cDg1aWpVZ3RWbm9y?=
 =?iso-2022-jp?B?VWZscFU2R0FEZVZldHhTMW1OT29DcFJkU0RlV1dORHBjZmZTSzcyWXdH?=
 =?iso-2022-jp?B?ZFJFVjV4cHkyT1JRNzJLMFlWWnQwQUxKbGNWRENoMkYzazk5RFA4WGJU?=
 =?iso-2022-jp?B?andTVDdCZFZYelpCSzdaOW8xSUtKbjZjUm9ZNU1UVWFYc2NZdVhzcVF2?=
 =?iso-2022-jp?B?ZmN5S1JTUGhiU1JvdWdELzRTRE1CMndFcFg5eEVZY0pvdm5HcjlSQUxj?=
 =?iso-2022-jp?B?clVrWHlmNnhWNE8wRGFnNE11K3dwemRhQ3VqRy8zSjIyZ3pvSlpQY0hx?=
 =?iso-2022-jp?B?aGF2M3drUnJXV3U2VVF6Q25JSFA2OExHcERHYXhhQjFRRnYzaUViQ3Yz?=
 =?iso-2022-jp?B?U2h5NzdCRHNFZVhxa29weko3QXFGNEY1Z2NqT3g1TG5tTTBDcUcvdEp6?=
 =?iso-2022-jp?B?Q3FxK200RXB2eVRSV3pqcXl6d2JXblZKTGpZemc5R2htTWp0SXc5UTBp?=
 =?iso-2022-jp?B?WWdYVmtyNys5R3BnQ0tnVHVacUwvRUdVYmhRa0NLT09vQ1FFeEplZmhj?=
 =?iso-2022-jp?B?K2l6N0tlRlVhUGNudEpqdWNaUU9uYW84azF6cG9SRWk0RGJjSGlqdzlJ?=
 =?iso-2022-jp?B?YWtqMGFUZHhKUVIwOVdvZEJRb0xSMzVQaGp1Qml3eDdMOUtXTkN0NjQz?=
 =?iso-2022-jp?B?Vk5KbitFQUc5RTI5SzVRY3NVSUkxTkd1Y2NsNlMrT2Z0bUtmbnVLQkJV?=
 =?iso-2022-jp?B?ekVrb05naVRjZmVLQW0xQlpuV2VqbmNEaHVlZzVGbzF2TnBEeU95K3ZM?=
 =?iso-2022-jp?B?Q0VLc2VMaFhyS2EzaWMyb1dBektCajNSS0h3R2lGUmFaM0YzZFc4NkN3?=
 =?iso-2022-jp?B?ZmprQkx2ZjREYXdkdVdiZFFsR2ZJSUV2NFk4VGRSU0pKTWJuMHVSRGN0?=
 =?iso-2022-jp?B?U29BZVVwMTZxcnZ4S0VhM05vbHpPemFiczBkWExtRFJBSEJuTjRKWnRR?=
 =?iso-2022-jp?B?NmFTWUE9?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba5db79-9e66-48ae-e21e-08dc9a62bc7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 06:46:43.9361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8VezYOoGaLiSTUB7To2j26Az0ILxNy7r8Kui8nu1PhlAJdgp6Vzl8/YjoCp64uq503SRgc5nz3y57wXvti74RFUTclR4ItooHYXZlOzz5KaCMlcm0SUlPiepuxiFiaGC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9577
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Jul 2024 06:46:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16355

Hi Christian,

Apologies for my delayed response. And, Thanks for your inputs.

Based on what you explained, my understanding is that there would be some s=
ervice / script that would run upon image boot (probably first boot), to co=
mmunicate=20
with the backend (on-boarding) server. The on-boarding server would respond=
 with the details like device-id etc. upon successful registration of the d=
evice.

So, to achieve a meaningful integration of WFX with CIP Images, we have to =
now support this on-boarding process as well (which would mean having an on=
-boarding server etc.)? Or is there another way to achieve this integration=
?  Would like to understand your opinion on this.

Apologies if my understanding is wrong.

Thanks and Regards,
Adithya Balakumar

-----Original Message-----
From: Storm, Christian <christian.storm@siemens.com>=20
Sent: Thursday, June 27, 2024 1:47 AM
To: balakumar adithya(=1B$B#T#S#I#P=1B(B TEUR) <Adithya.Balakumar@toshiba-t=
sip.com>
Cc: cip-dev@lists.cip-project.org; dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC OD=
G Porting) <dinesh.kumar@toshiba-tsip.com>; kunijadar shivanand(=1B$B#T#S#I=
#P=1B(B TMIEC ODG Porting) <Shivanand.Kunijadar@toshiba-tsip.com>; ashrith =
sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>; hayashi kazuhiro(=
=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I#G""#M#P#S!{#M#P#4=
=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>; Kiszka, Jan <jan.kiszka@siemens.c=
om>
Subject: Re: [cip-dev] Regarding support for WFX backend for software updat=
es in CIP Images

Hi,

> The mandatory configs that are required are the wfx server (backend) URL =
and the client-id. As per your suggestion, for the backend URL, providing a=
 kconfig variable so that users could enter that value before the build see=
ms a like good approach.

This would be the hardwired default for the upstream wfx server [see below]=
.


> However, Currently I am not clear about setting the client-id. The client=
-id is required by wfx while creating the jobs for the specific clients and=
 also to monitor the status of each client device (like update status etc.)

Yes.


> Setting a client-id also via a kconfig variable would mean be to build a =
new image for every new client-id which doesn't seem like a reasonable solu=
tion for production.

Exactly.


> I am not very familiar with how such device registration / identification=
 requirements are handled in a production environment. Do you have any poin=
ters in this regard?

Usually, you have engraved in the "golden image" sane defaults that you wou=
ld want to roll-out to all your devices. Then, individualizing the device i=
s done by onboarding it to some device management backend. While this proce=
ss, the device gets an ID and is henceforth known to the device management.=
 Also while this process, you can do further things that are device-specifi=
c, i.e., configuring SWUpdate to use an individual client-id for wfx. Note =
that there are many ways of how to actually onboard a device but the princi=
ple remains.


Kind regards,
  Christian

--=20
Dr. Christian Storm
Siemens AG, Technology, T CED OES-DE
Friedrich-Ludwig-Bauer-Str. 3, 85748 Garching, Germany


