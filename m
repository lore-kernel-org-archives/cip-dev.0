Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9DDEB64D7
	for <webhook@archiver.kernel.org>; Tue, 20 Jun 2023 20:44:19 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web10.918.1687293857068880427
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Jun 2023 13:44:17 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.155, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 35KKiDhc025714; Wed, 21 Jun 2023 05:44:14 +0900
X-Iguazu-Qid: 34trpHMSnZ18XNojnk
X-Iguazu-QSIG: v=2; s=0; t=1687293852; q=34trpHMSnZ18XNojnk; m=IsgDoKtpmnmpxb/r4ay12X/J0QUbvh+x9NfiY5cJTv0=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1512) id 35KKiBEn022224
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 21 Jun 2023 05:44:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKZLiXtHS3BHHEZajvR1EqZToPTDvufAel6MOWLmEK02XrJWqLLso+H9bTEQfZEggBtVrAdrvEJGfu2Sj21IqDUlz7ZqoX53uLR0qm4qdmol/TGFR2H4fLeKDOnnMpgQlPcvrUQyIRF4wLxQrPixbZc7E8pAPteLDsECAd6uF2M1M67/Xy9ZCf7EQI+0pB4KBqLkxXnEoVW8E3s/HfRPz0iluC8LdTEBlnkDfizaU3uNG3369TrIgz1vVNX/Ml9O3JpYDfYMfBSivFxz9Z6xeGHS8RKnOXutu9JeBGmpwkbLv2DnwjKJfxe6NFVUwjraH3MLioWUMZyvw0waZohGvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nspXUnTnrIRwPytD0iZQLgv6wFQ2urYDAy3Ic8A+nfU=;
 b=QRbYltbJnxrv/4fVpsx2PjNm5EKF2gd5T0aoXlBujyp3vIZStRsuWj146bPFHRIAPMLOs7oXEOzwrbTVY4n3/rFH1AAbrbqb2vMSy4w85Qr9gonQxuk3OJxuRPy+jtM+zz9CbTb6R/k884nwSIzAZoveL6Zm8ncohC6S/7jG8DK3wDmYnc3+DkYmDigYFpPOL1R7BD6LCkO1+So9/RM2edz5En5T72fDhoUu1RNwsC2D6/eBm7659iDsmf/IQRMmYJtjNj06yOJM84Gpp7jFLbPii8YBKg1u87bc6QNtE8UVsDDlXdvI/LcsSOLVz8RNlNKA1QXDg6kSqsWzXTOjAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <iwamatsu@nigauri.org>
Subject: RE: [cip-dev] v5.10.184 based -cip release?
Thread-Topic: [cip-dev] v5.10.184 based -cip release?
Thread-Index: AQHZovV9F1d03lzTuk2et+XOb39MXa+UKWPA
Date: Tue, 20 Jun 2023 20:44:07 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420019185CFB228CEAF610A925CA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <ZJDJPH2l/CgrP5XW@duo.ucw.cz>
In-Reply-To: <ZJDJPH2l/CgrP5XW@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYCPR01MB10151:EE_
x-ms-office365-filtering-correlation-id: c043c32e-a15e-4480-f20f-08db71cf17ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Fbpv/ZgL0Nez2OCZhsr41JjwkK76sYP2GMpcat7Wc5f9meZhCYPfTTSQYAuGWOI7wT2Lay2VRo6nOALIe0NwhikSEJAqmG6kLEFa6A6spjg0IxoXE2If8hhJ2KDKemyTdzr1h2ZtL4qDBDBq9dcYmAY7E7GaCi52aepo3wTnDmzLwcsFL9gH97XWF5ZRL6L1ujk3xqDJ/w735Cl254TSQRaqX8tSMXI7WiCLVtPdN8ZGGpXKBcyw1S6dpSMNI8W8Kj5Wna0xc8Z35f3o0YQheihDpBDgyDdtu0oxSdBwlp/s2axa7Q104pv9T7JVn9HfFQHZMfK22o01sJowB/QvMSWsbmIzeUucxAhagJYPGlzou67BAQckeAo2hjwk29pFjSsHNwCNh+eaavSOiWmGRh9BfGTSs6FwzDmFbuhLfv0Bxee+huEAFzk5xl8rqLU3vJq3tkt80ZBjlwNYo4WnKB4/G16THUhLo6zdf1qlYw4bPE9zCr4+MgG5KFYrOZUlt4Plu1kvx5kouvQBTULqVBkBR5LvLuTp3Dp25S236N6K6IlWBhnC1XbDW7D97QW0lQ2osxv8g5nPoTYswwYhgj5xjpClbLUAUjDP7vxWWehAyNbOedcZqr1RPKARW8jdh/vhQnpIl1nUSUHlxbAtcA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199021)(110136005)(478600001)(8676002)(41300700001)(8936002)(66946007)(2906002)(66556008)(66446008)(64756008)(66476007)(76116006)(4744005)(26005)(186003)(9686003)(6506007)(71200400001)(5660300002)(316002)(52536014)(83380400001)(122000001)(38070700005)(86362001)(38100700002)(33656002)(7696005)(53546011)(55016003)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UEYzb1hYd1lqZC9sOTVEa3dYT1NuWXo0MlRqRHdyS2pqYWY4bURSYmw1?=
 =?iso-2022-jp?B?aUFDT1FHelBiTkRCcFdsZlY4cUpUOU5NZ0NoaVFsL1o1Y2VCZGFZd1pH?=
 =?iso-2022-jp?B?UGJ0aVZXTXhocDhYUEdmZVl5Vk9peVNPUW94U3lROU53VjhsZ2RiWk9G?=
 =?iso-2022-jp?B?aXcyT0hkUmZCQStlVG9HTHVYM0Vtb3N1OS9FTWljelJ6M3JWVi9Qcm9p?=
 =?iso-2022-jp?B?THJrRDI2Zkxka0FTSEM2eFZNZzdRWmFMSEE3dXhZVWE4SzRYaGswK3c5?=
 =?iso-2022-jp?B?aWFycENkVWQ4MTcralhXblhyWWFGZWtCN0RpUnE1dTdnQldJeVZ6Yi9W?=
 =?iso-2022-jp?B?c200OThvbGNRdDNERGZ4MTBxMDVWaUFZbVovUEprWTQyenVIRGZ5UlNl?=
 =?iso-2022-jp?B?ei9HNkJUZnZleEVVakZIbWhHK3YyV0xrTS83a0xYT3YvMm03NVRYb3Ft?=
 =?iso-2022-jp?B?MDZHR1RVVmpnUnFrTkZsTmhBSUpzSFRIM2kya2Q1eTBDK2t0d2tucHdZ?=
 =?iso-2022-jp?B?eU1QYTFDb1o2RDRtaVl6dXB6UXpDVDEyYTRKblI3cmFEZ09zUFlWUWMr?=
 =?iso-2022-jp?B?dGJYUElPV3NXV0hQRitYNjNQTWd6OE5WNGFHZEpqQUlEaGp5dklNd0Y1?=
 =?iso-2022-jp?B?OG5JbXlYRHdsZW0wdGtVRlp0bjR0Y3lBNDZ3eC9hSVR0Z3NxM3VJSEZM?=
 =?iso-2022-jp?B?VERIOTFFYzc1Z1RGMVo5Sm40eFE1aEZkNitUTUFGc2hKM2VuN2hSWURj?=
 =?iso-2022-jp?B?empzNXF4NklNYXQ5MnhBM3hIZlY3V1FWOWZXb2ZPNXV6amxVYkdVdDMr?=
 =?iso-2022-jp?B?M2Z1WTBnT2FNaGxEck00dXpyTkJkYi90a3FVQ1FoK0JHUWtxWUdSSy82?=
 =?iso-2022-jp?B?eU5zMWkzQmhCUDIxaUowVWZFeW1kTmp3WS9vdzNoZkhlN0V5eHpKNnlh?=
 =?iso-2022-jp?B?OHhnazRYMDFSZFlGUmJDc0JVb1hpR2t3YVpaT1RhOFVBdEF3ZkhOT3Bj?=
 =?iso-2022-jp?B?aFVpNTh6SDMyeWVidHBpcGRlRmtidkFneUY4T3ZuK0p6T0VqZzV1QlAr?=
 =?iso-2022-jp?B?bXdZa3dlOCtOTFZDQ09lL2pzRFpDRFhvSkNNRUwrMWZIUnNjVHc3Ylll?=
 =?iso-2022-jp?B?VVRZUWhta3RTWkdoWnNGRXVGbmU4OSt0TXBlNG90bVlhREtXd0poVjAy?=
 =?iso-2022-jp?B?OWZNQVFycUljQkZxeWs2QnhjaTlReHY4eDAyMlcvTDd0OUtCcEtyV0Ez?=
 =?iso-2022-jp?B?ZGIxTUdrMXNzWktSNEZHVmNmRS9va3RSakRENGJ6TG55VUFuYzVpWnA5?=
 =?iso-2022-jp?B?c09nSExGc0lacUYweUlMdVpqN3VTb3FGUzNETkxuWk90RUsvemg3KzZs?=
 =?iso-2022-jp?B?NTNVc05HcHEvVzBqbkorcTUxdHRxWlBOUUdjTVNBVzY1WjlkNVRYeXVs?=
 =?iso-2022-jp?B?dEVsWk1VZVlxeXVhaXZnNUN0aWVTWW5oRmZZV0cxMUl4MnVIdE9yclpS?=
 =?iso-2022-jp?B?MnBHVDZyWDU1U29VYUd1UENZSnIwU1JqNk9vaFFoby9CNnZ0ZEQvMm50?=
 =?iso-2022-jp?B?Y21oMDRQNmhQVUxiTDJxeVdHdGZKM2JtVThnWnBQMlR0cTkwTWFUYWhj?=
 =?iso-2022-jp?B?TDFMVTVDREduSE5YL3RzeWpKbml0QWRDeDhYbEFCY3ZYNWJ6N283MVpH?=
 =?iso-2022-jp?B?V1RxWHpYWW9XTU1MUkY5OXZKeVNCaTNIR1UzOVZEdmR0di9UQXR3R1gr?=
 =?iso-2022-jp?B?YjVnM3FCNGhzbk5QNXpTL0xsSUVqVmJyamc4R3AyMHl0T0dnd0UwZG1M?=
 =?iso-2022-jp?B?ZitzbnIvSnNvZUhkbUN2eHZkc1NyL2h3TnVGWXZLVnJPRTRYT3pQc2w4?=
 =?iso-2022-jp?B?b29sNEFGdlZubU4yWTFOaHZXWDNlNDRBQ1dPVy9zdWVUMEJLTlJKamgy?=
 =?iso-2022-jp?B?TWZHN3dWcnZHNGFKTXJ1U3lQOFRlZmpOVmlQR2FnejN2Y1lmNm9YeVhl?=
 =?iso-2022-jp?B?bjJSdmVpRm5DSEpwYnZjdkluREE0ZlZ2dzRTVjJ1WHJIN3c2QXA1Y3NW?=
 =?iso-2022-jp?B?ckdhYVZrT2hma1lZRmxyKy92UldKTG5vZklqc2RmUk00bXc0RmNXV2w1?=
 =?iso-2022-jp?B?bWJ3OWFPb1M5UnpLclk2ZVJkSVBaTTVjYTRrL1d4UjJQVTRRZnVMdHo4?=
 =?iso-2022-jp?B?M1cvc1VNSmVzMFNVSCtSeEdtcnFVZFhOYlczYmpmY0NpaG9xWDIzZEZS?=
 =?iso-2022-jp?B?dXlkUzkveXFudEMvOVF2eUdrSC9VSWZWSzRNN0dXbE1FdmJlS1ZQQkc1?=
 =?iso-2022-jp?B?dzN5V1B3SDdpNUN0M2hHTllYVndoMHo2eEE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2O+yGUZFySyvZmw7fXeLzgdBhRtzu2+v8guw+dgVOkBq4Fh5SCU43f+5XHI971KqbRPUaAITkaAQDJXj3baAaZl/jr+TdsGgal+lqaxcIXF7+BPNakRl9M82SmEe+P6l8yfY3bIXizoUFHzHb9n4eDluR4mwZtSILD0lWXa91jrzy1WAfTljcOUG4M/Su4+WwjW9YdDHOkLo1dA/lc20bFT4Sn5JGX1jeZJ/Ztbfp4QAZ4E0H0ivlu5ZVntTATUXGrypViFNfV9sSMmAVZbEhibf/1xb8OKU8O6XqY26E1noYj8l2Md/8SQoScVU9Z8YG5J+jdb+S7T4Be/g+2TwjYdJxOnwVyeIXY+fUDhg4pDGBh2mvRwDFPTymaAoGUDJ2iQvoqTs50XDnuQ1OT8QFDkcLs8QLPBKChH0lM1+mctrMBMSqkR0KrXI4tBn8JWi5Uc9UI9kUgVL+/h/nMMe1gC6Yaf7wk1q5S+skRIAdY98e24TBLEynlzkfTO3REjGxImaRlJTP8XFM6Jm+6iyuupQz4GOMeXvl3QvWP6ebrCYz80UfvjxrGZNC32BF0EZtv7GfIJpCkv3+xn026BfujIlCmFSvp49jb8MW5xwBquyKver/22v25rJB4hqlWy8Uik8SIuuTAlKmizLg7csi9vOG160PPRZ+if3YAjqufUAX1K80hx5rey9y8tiTpdcDfy7x1ttzHDKlnsKu87+RQaYhHmJuugM2a8G2HvlpvlB+Z4K3pO1V00/JqlwYSPfCal3Jb/lVN28uFT0UaHiYtb/9XEqhP+weluhYcZza97X6vL0ZiZfO60wejBB2czTyLfUkPQXIFGO70y6TtvEmQ==
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c043c32e-a15e-4480-f20f-08db71cf17ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 20:44:07.6818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JKzoiOLeD7LQI1C3db2nycO3nia9a0VLEcndRcsD8FyDX+wzgcmziBeFSXiplbkbfIY82B8aoksortA1yy2g2ijKhgum4LvQN/bCffMjjQYLE02VINeEjzdDiwVsDl2X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10151
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 20 Jun 2023 20:44:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12089

Hi Pavel,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek
> Sent: Tuesday, June 20, 2023 6:32 AM
> To: iwamatsu@nigauri.org; cip-dev@lists.cip-project.org
> Subject: [cip-dev] v5.10.184 based -cip release?
>=20
> Hi!
>=20
> Could I ask for v5.10.184 based release? It would make -cip-rt relase eas=
ier.

Yes. I will preparate releasing linux-5.10.y tree with v5.10.184

>=20
> Thanks and best regards,
> 								Pavel

Best regards,
  Nobuhiro


