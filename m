Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A13C6FD1F
	for <webhook@archiver.kernel.org>; Wed,  3 Apr 2024 06:16:05 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.4650.1712124957249134543
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Apr 2024 23:15:58 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 4336Fm4N3689030; Wed, 3 Apr 2024 15:15:49 +0900
X-Iguazu-Qid: 2yAaGcef2t6rGvvyTA
X-Iguazu-QSIG: v=2; s=0; t=1712124948; q=2yAaGcef2t6rGvvyTA; m=jKkmeg7c2P9tQz5vdsCKG191bkefw5Mul7j/9iK2AjA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 4336FllG1173023
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 3 Apr 2024 15:15:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMmnQQysn0TrXRZvkwUTmHvZAaP3fOuN30SVLotXmtJ0GzqHZWCMnfLwTde5VdKocv15L+j9SPzkO8J0GT1rQ89eICjS9Pc35FkNeGD6aqZ3NFCyHjIbLu72FCzD1c+0NiXKqjsb8APXlUMasCJZj3Hwpvfwr4iFHxoFiU8nn+wz63I3SA39ML7sdcwBTwgJBZTS0Fhrn1O2UfmvC6f3xiljVrElyFDV4I5nPb4IR8GJWAO4gYgzqu8m4ZnIy//teVr8sJ3IiZ/G/jKw/t3zXi7vEJQqT+k86E1j22CCdgPOB4ef+TB4mFdOdCzhv9HN0gM2UNk5vby4GBV0YmaGHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=do2WvBdg+uRznfJR8AOuOtgUY40kXdcXQnhqTQhO/P0=;
 b=iHeoVIFDBDzBZAhEcDVr/w3CXUztFgAchJJVCzhNg6Pvy5H7yUJTfCiGgM4Rs91SobBJAVb9pi7Q8j2D4xMQp4o3OsiL3fOa3kVP1IFjXi1apULlKTaiRyzWhHKIBnXBAPslKbDf+KAfQjGNTUYoUELBPrb/BP1ngC9lsTq824Yl3eFQCqhQN0o1j0yNyoGk9OXVecTdEk83axipg5w4ecD8YnQDOuD2b4Vhz37ZQZHEBr5frBnbCTlXcV/sfe4FsTvxbg0itSQ+zLPbI1XTdpjtR0AMXt/Xp73oBNWeW4THd3sAZ8svDxWkZRBM5Y4UmK9tNMe3WKjo0bawsr1hag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <cip-dev@lists.cip-project.org>
Subject: RE: 6.1.83, 5.10.214 would be useful -cip releases
Thread-Topic: 6.1.83, 5.10.214 would be useful -cip releases
Thread-Index: AQHagssn1FGQ683O2UyW3WrhvbmV5rFT+O1QgAIdKQA=
Date: Wed, 3 Apr 2024 06:15:43 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB638805BF298A7488E54CFB32923D2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <ZghRfAeHw2i7rdjF@duo.ucw.cz>
 <OS0PR01MB6388AD7CE5977F6F9494AD05923F2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS0PR01MB6388AD7CE5977F6F9494AD05923F2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OSZPR01MB9440:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 aS+LIM7cm8jV+9BxxFFpGyPl1zsSud6auzM4hETWuNUHgSOWuz7o3PPZO0SUtVCkt+oXICxHNo37kBdgz5/acC14Q5urkhLZW1r3Vabsg71LtGEkc3Of7YlNr7DTPLjOWgE8ugwtbtWG07QsJcAbRfOMwF1NLpedpS+2oZZ0StLKk9KUsKLNwjI3V0qZPQ12xVHKZh4m9IlD4iIkOl22Q/TTi4Ehj0ptmbZ5ONc+B77wOWRrbUGuwO9P+T0tT13bWz3/iHg2gSpzO8FM/g/OByq5+eZr7DTgCz1IZRLkmiYiueLidOoXTkcR6IXtKN4ZgPa26D62wLss/OQZN8gLuS7gBoYtUhrGZ5V/vLMPNfsbgb67A0veFldqqjS0UxcybX9ZcJUDs+2Ib/JJlfWPke1J39Xyur0dLftP2m3KI22bmG2FYrFBASamAAG6F5jnk0DigFOQ28gXOegihrrE+BkHjeElqCxcZ/5/rwFi4ccObv6cuOizSbWRo/VsK7SrrFsCkOtPEBC/vdBtFdoNJpviUcYUcewz95jx7km/DAjBeSSmqGxhRWYBUkBc5F/+I2wibpnoGqrO5nx/rnoGGVOGHlzLy0qSA+Pjc1lsIZWAzRtuEFqPa22r4/RtB1ZP4iRh+B7QzaBGC5/LeMbWlRr5E6cv5xblnWpM9ZsppDg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(95630200002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?WnVWR1d6amQyQUZHVmk5UXliYVg4YmREdUlNcnpVYks3eGthRzNPZjJv?=
 =?iso-2022-jp?B?MStnaEl5bWtrMXdaSTNmcXJ4b29VcS8zenhuNTN4TkRDV0pKeWJiTklS?=
 =?iso-2022-jp?B?VjYrZ2phdmFocmtQTGpZNlJyUEJkM3gxUXoxS3VSeVN5UGRmaXEwMDh3?=
 =?iso-2022-jp?B?b3VkU0FKcENhN20venZGc2t4SU4vMVR4cWJZUEd3bHhHakxJVzA3SGhW?=
 =?iso-2022-jp?B?aTBBaUhFM2VyYUMybklYTnBXS0dmbmplUXhBbS9rNXpLQVpTNjBWZmpJ?=
 =?iso-2022-jp?B?SUx2d2grZXJ4b2RPdHZRZXgzNHpvcmk2eUlGcGZ6U3pFVmV3R3RUWWll?=
 =?iso-2022-jp?B?MENvWjR3N1N5OGx4WGlMb2dEZkF4b1NCODNPL0ZUQTIyL0k1aFNUa2Jl?=
 =?iso-2022-jp?B?STRoU0dXTkpjOTI3WXI0QUF1RnBVRnJvV3Q2OUF3YTBOYXNuNkdXb3hy?=
 =?iso-2022-jp?B?VkpadUFrd2ViaHZQdDdCZnBMcVgyVmk2REpVcjgxUjhZVUI5dXNBTHFK?=
 =?iso-2022-jp?B?MU5jeG5XTjFrU2s5NmVSVzZLTWxNWW9XKzJqTFJGeGFKNndWZFNvd1M0?=
 =?iso-2022-jp?B?SmFvUkxYMUVWVDF5bWM3YmZBK2FXYTRDYi9PNHVDd2FQY25oUHJvL1ZT?=
 =?iso-2022-jp?B?TWNLRGMvcDdhZkFqQ0xjTkZWQzZQenVKSkpORjgzSWhCL2hIeWkyUFJZ?=
 =?iso-2022-jp?B?N2p4QkZvWXZjbnZaaUV3TkdPYkQ1R0tlOVBsY3F6eXh4N2tOODU2MHdK?=
 =?iso-2022-jp?B?aXBoWXhMZkR1ZzJQQnNlWXVNSzFMVDVmdWNCUHZnNGw5ZDhjOGUxdzRQ?=
 =?iso-2022-jp?B?bk9kc21FMktEMWs3SGVWMjU5UHhjUE1EZGdIMFFSbXhIN09rK3R0OGR2?=
 =?iso-2022-jp?B?VUVQT3NoRWQ4WWR6KytFVzdyTkRlZEJhbk44UXg1eUZzUUpNNEs4OFha?=
 =?iso-2022-jp?B?OENIK0xQWDU3MFk4NWZWY1JRN25NK2puRkVoMVNYOXBFdGZDTTJoZnZS?=
 =?iso-2022-jp?B?eWdIS0o0UTJBWkxvVG4yTzVCK3REdEFxSTViZWQ5ZWtHbVgrMlhQZUht?=
 =?iso-2022-jp?B?UXlkcGRoZnkvbHozN3dOZUN1RWdoclFINDg5SlE2Qm1NWUFaMUpwQUkv?=
 =?iso-2022-jp?B?YXlUdE1WUDhMa1ZGcHJ5dk96TEVrTGxtYmxEZzlEejNQSUR5Q1Jnc29G?=
 =?iso-2022-jp?B?aDVabEdMUklZRnduUHJTQUI1VUk5RVNyYi9Td2Z2ODF5Nk9OZHFWSE9Y?=
 =?iso-2022-jp?B?MHlYVHlwRFR2ZHJ0ZGQvcXAveS9iK1hoMkpFWkpWc3NoWVNDczNxZ2pI?=
 =?iso-2022-jp?B?V0dtYmwwb1V0c2QvcEFZcC9HeHhETzM0c1ZkUWltc3FJQitsYUNTeFY2?=
 =?iso-2022-jp?B?WHphWVA3NDM4OEQ5bFJETG9ETUowS2ZVM0pMQ2tqQ21FbC9JcXN0U3JJ?=
 =?iso-2022-jp?B?a2NJZjNUYXEwWmlqN2JWYjZaQ0RWeHgwZmhLT09hbHA1dzkySU56d0gy?=
 =?iso-2022-jp?B?OGlDSHN0Q2l3eE54VVR5Y2paQWdNQmFXbURMUWFtVGtobmVjUk8rb1l0?=
 =?iso-2022-jp?B?QkVWVTVWWlplRnRKb1ppVEpuYlpId3FTTzQvT25sNlVQR25zZStPUEF6?=
 =?iso-2022-jp?B?eFJ4YlNMeGZYN1hnMy9UYkRUYVVLcU4xN3BYTldBc1hwRTl3VklVQTBQ?=
 =?iso-2022-jp?B?emh6anhoQTJMZDVlZFNsV2tGWjZ6SDg3bVVPcThiOGNmVTJEMVcveklr?=
 =?iso-2022-jp?B?dHBTMFgrMjlzRHVxb0k4Um1Ud202YnNTY0kvQnc2L2ZDS2d2M053UlpP?=
 =?iso-2022-jp?B?YTBzQU9QZ2NOSU1yU2pxQWlRRnB1bGVKV3MxRFhnT0ZnUm15b0NjYmJZ?=
 =?iso-2022-jp?B?d0RaWjFoZ0FxZVF6ZXlFbnZpOW0wbWd2VkNIZDRtUDhrVitOQUVub0Rw?=
 =?iso-2022-jp?B?S3NicXVRa3krV2s0UmRiTjBGSk8rTTB1SENmSm9vQlNlcW9iVUlqbXdY?=
 =?iso-2022-jp?B?ZlRaV2swM3pLREl1YzZxN2w5S2Uza1dzclFoQkI2NzdzdHNNWEo1Vis5?=
 =?iso-2022-jp?B?TWE5OFczNlIzN2hvNEd1bjJpN1VDWk9tNnVyZWNYSnlTSldZR2JucTBP?=
 =?iso-2022-jp?B?anVzUjQxbm0raFI4MlVNWmVmOTRGZEZ0S05DV2FRK2ozUzBRRFBXWW1v?=
 =?iso-2022-jp?B?TFNiT0Q0OEhVaHNuc3JsRU1mZW9NUjJTamRudnFpTllrTUJ2WUUxNS9Q?=
 =?iso-2022-jp?B?aDh0d3BhWGJRL0RxbnViVDNVSVE1WVcrRjAreUxKWmdLZFlOYkNvcEVU?=
 =?iso-2022-jp?B?Vm1hbXlqNWNxVzlDL05OS0ZvdGNOMUNOY1E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d5ee28-d3f3-45b4-053f-08dc53a57e4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 06:15:43.3225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 90a9BzDW2BnaBND3/9YJTodt84avSGUlXxtRYjUaVkyRfYfdNfLRWI+YG8JAKx2/dsW/Nx/+hgj6phaJOULf1KQIVlSO1/ZIivdPLLDh5Uh/B4jmj0Hv9Iaamjal0g85
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9440
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Apr 2024 06:16:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15482

Hi Pavel,

> > 6.1 and 5.10 -rts should be released soon... There is 6.1.83-rt and
> > 5.10.214-rt is in the pipeline, if we could get matching -cip
> > releases, that would be useful for me.

5.10.213-rt is correct?
https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/comm=
it/?h=3Dv5.10-rt

Best regards,
  Nobuhiro

> -----Original Message-----
> From: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D=
#I#T!{#O#S#T=1B(B)
> Sent: Tuesday, April 2, 2024 6:57 AM
> To: Pavel Machek <pavel@denx.de>; cip-dev@lists.cip-project.org
> Subject: RE: 6.1.83, 5.10.214 would be useful -cip releases
>=20
> Hi Pavel,
>=20
> > -----Original Message-----
> > From: Pavel Machek <pavel@denx.de>
> > Sent: Sunday, March 31, 2024 2:53 AM
> > To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D=
#I#T!{#O#S#T=1B(B)
> > <nobuhiro1.iwamatsu@toshiba.co.jp>; cip-dev@lists.cip-project.org
> > Subject: 6.1.83, 5.10.214 would be useful -cip releases
> >
> > Hi!
> >
> > 6.1 and 5.10 -rts should be released soon... There is 6.1.83-rt and
> > 5.10.214-rt is in the pipeline, if we could get matching -cip
> > releases, that would be useful for me.
>=20
> OK, I prepare them for release.
>=20
> Best regards,
>   Nobuhiro


