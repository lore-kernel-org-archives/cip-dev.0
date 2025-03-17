Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274BAC282EC
	for <webhook@archiver.kernel.org>; Mon, 17 Mar 2025 13:57:30 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.52941.1742219841919034605
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Mar 2025 06:57:22 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 52HDvJit2731804; Mon, 17 Mar 2025 22:57:20 +0900
X-Iguazu-Qid: 2rWh5b6vFaoEIQogbI
X-Iguazu-QSIG: v=2; s=0; t=1742219839; q=2rWh5b6vFaoEIQogbI; m=JKYGzEmQ+oVOjjqwrheVQrgvI9m9To1/rHjfWLzx8sc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 52HDvIlD407327
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 22:57:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XeZyoxBAIVrMJf7YhLffhra6p2UbG6yZlE86x4N36CNTG4a9+jLak2RhJDs7ccegqgnUPoyz8o0ddZxceQJgoM+HG/+NBUWjNLXzd4Sqjfm8EKCKXCiPVwFA1JX7tb8vF/hUniFDXKN04kLA2jvE+rDGv+XhNgZDwRwljnhVMVxSMq0snTYJeE+lMap/qgmsjvXft60SsPpKQBS1wQjmGKpQkINqo8EBxBSUXATZPuu43Z18/hgV5LEC7BVdbl6GUwjeDjK0v/TCY/9DB963hUrOc5wXDBqtvPVTkehZ00qUO/sSRpQ02gUl94U0Kqbc+Y2PICP++CkOxSZY27pgCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYLz4mWl6b8HKgrCMDDSwsTpP57HPCJG8No4NqWxn1s=;
 b=xd9N1Ea+KD9SBj5IxDsdlYSFLphYK9AD6SbXeZKilkMIfUAWEe8VHjESei8wCgtCh0wtM4PKOWi7LJI8RkaSVs3w+eobwlTA1AE6+b02vrUHBXTEFJWV2fHreyxOFIjbScAIsMKQ35Wi4k24CGKfuuc40a9dDx3Ay+NaeyLI4ujwU5R+BaesHjiT26hnnWD7BZstYSaIwmHsuhBHgNms8wSCQ8z0vY6gTW4ioMOsIN6/mvvPL4yLPc3yL9I9uoK/hei10uS4tIxEtxyxPR0fQp1JycGlHOA68uIRrC+6YUmJD2EZ2yxqErAPiftcn5jyuPlOKakD0rVhCE3UYf2PlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <jan.kiszka@siemens.com>, <Adithya.Balakumar@toshiba-tsip.com>,
        <Sai.Sathujoda@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
Subject: File server for zchunk swupdate update
Thread-Topic: File server for zchunk swupdate update
Thread-Index: AduXPMDwGbkQ98swTHSVcGfABwDcxw==
Date: Mon, 17 Mar 2025 13:57:16 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB11075908DA987ADCDE33DD899C7DF2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|TYRPR01MB15055:EE_
x-ms-office365-filtering-correlation-id: 752aca17-d841-44cb-3a3d-08dd655ba066
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|8096899003;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?djNMMHg3ZXFTN2ZyamRCRVBsY05aalo0UGVJRmszWUxsU24raGFuVU92?=
 =?iso-2022-jp?B?TGtXTGh1UUxEeEFwcUMrWVA1UnM0WlRiYjU4bko5S204OU1sbUZzQ1Ux?=
 =?iso-2022-jp?B?allDQWNEaVR6dFpPNkdGSVVMOFgxM1E3Smw5eXlCaFl3ZDhVRjk1dlZW?=
 =?iso-2022-jp?B?VHhjM0pUL1Y1a2NpeFFQT01xRDVqNW1pZ2tKem5PVlZwWVk1SkVIc09a?=
 =?iso-2022-jp?B?dzVROE1ENW1mVlVic2xPQ0ZnblZFK1o0VjZtYWlLRmtCeVd0Wms4b2hN?=
 =?iso-2022-jp?B?RjAwNE1HN0YrczdNUk90bEtkRGp5WVIvTTdGcHJrSm1YTHFFakc0N2R0?=
 =?iso-2022-jp?B?TUlzZmVlWldEbHMvcmMwWkVNVGhIeUhsNXZrM21reFlDL1o3dVd6dXJQ?=
 =?iso-2022-jp?B?WU5aaGI0K2VReHFZb1c2OTlFbllIKzd2YmxpVGxGUGwrbFZSVlR2NlFs?=
 =?iso-2022-jp?B?THZmbmYydnd0bDFBcTZlTS9RS0FrMmNmcnZmZWVyelA3R3UwZEgySmJM?=
 =?iso-2022-jp?B?WFlqM2JvckRWamNYcHFRZGtEUEdJbS9tM0JVcWdrbE1YSXlBY1ZpZWVO?=
 =?iso-2022-jp?B?R1FhaFEwdVBGS3hyR0JBVXVZMTREN0duVkV0S0xLL2FKSnYrTGFKeVhn?=
 =?iso-2022-jp?B?b3o0U2twYTkwNmovTzBzNVJWMGx2NExaaVhYQXZsQ0ZwRU9vVkloN1JO?=
 =?iso-2022-jp?B?RlI1aDRUUytoNmZSTzMzcUU1SDl6QzNwaGcxaXByVmFXQ2JxclVJUlFP?=
 =?iso-2022-jp?B?STQ1TS9veW1WRGVsNzhYRnFpUjFVb2FsK3dENmJNSm5UV0d2dWxQd2Y1?=
 =?iso-2022-jp?B?cnVoYit2a3YzL2N1L2tnTzNVcmtlUTlFZ2hQNUJjaDg0UmprbGFwZnlt?=
 =?iso-2022-jp?B?cmR3M281eGFFSGkyeGRLQURkVVdQZVBydW42c1YxLy9nelRHai96Smln?=
 =?iso-2022-jp?B?eXViTmM3Q3crWlBGbjJ1YjVHUGV5ZkE4bVRVanZGbEducGt4WDhNYThR?=
 =?iso-2022-jp?B?aGFiNmozY1BpZ3VZS29KK1NWK0tneWhOd1l2TjF0TDJWamFGeTVseGZO?=
 =?iso-2022-jp?B?OW8wWXVhMXovZU1SR1JwMWZ2MGdXdnBzMEJVVXBtVHJRL2p6NUhJcXlk?=
 =?iso-2022-jp?B?TkV5d25IUkl2a1ZaSllJcVJBdmF4Y096ODl6aEVhVEFNMldHd0tkd1VZ?=
 =?iso-2022-jp?B?bjFTQWEwV2Iwc0JnVHpaakdxQ2NHcTlmaHhVYXVtM1g0TlFYeThBd2lQ?=
 =?iso-2022-jp?B?TXJJSzlXSFZJRGlZU1ZNNUUrbmlYdnJmaWMwUjBmajN5bkE1b2ZOTm5I?=
 =?iso-2022-jp?B?MDI0bmJSUHdkMVVETGZBQ0VMeTc3ZmJmODJBTFROb2VDeURBaXdKbnhS?=
 =?iso-2022-jp?B?V1ZnNWN2MmtVYkEzYUV5N2ZTYVJTMGtnK0NzVHZSNDBmL3dROXdmL2p5?=
 =?iso-2022-jp?B?aUVNanc0NEUyQzlPNVVtd1RUZjdwREtGZ2RkSGxIWDUvZTVRN3VEODg4?=
 =?iso-2022-jp?B?dDRsd2xFSGF2VUhnRDRyY1lYM1U0d2hWZEkySSswTGYwZUJQVDE3dnRp?=
 =?iso-2022-jp?B?K3pPRElDRlZuS2l0cGJxRzVjOEgzYXlwVmNkMUMzZzVUemtZV3F0dElD?=
 =?iso-2022-jp?B?dlIzOXdwU3JSRDRjclV2Yk9MS0EyVXFuUjdnMmRUaENZVEZYOU1QbkhL?=
 =?iso-2022-jp?B?T25ud0M0Vi8vVXdYZlBYNk4vSWI5Y1h5UkFSblFPUXpYcmZaUHpqbW96?=
 =?iso-2022-jp?B?TVU4SkZTb0pwSi9wTVp1ODBvZmdqVk5mL3lXZzBQRUxSeEhYb29DMkt3?=
 =?iso-2022-jp?B?MjlQV1lTZTFuTWZlUzR6NGdUMFhneEF3RlI4d2x1eHp3Wm12aGlabnBB?=
 =?iso-2022-jp?B?akIvUGQrajBtc2NjMzlXcFBaTkZ4NVEzdGdlV2k5ZDd2Lzk4TFhraWRt?=
 =?iso-2022-jp?B?Nk1RSWxOUnZoSkdXd21DWXBtNXB3MW9GaUxFeWptbEMwRk5vTHBDZ2h6?=
 =?iso-2022-jp?B?eU4wcWRPdXRxa2VvVUkweDBqc1pTZnJKUmVEWjhOZ1JWRkw2Q0lBTWJF?=
 =?iso-2022-jp?B?ZS9QRHd3K2tQQjZVSzZ4cnduMXA3ZGJuWE1UTS9BSm1Da01wRUl6U0Iv?=
 =?iso-2022-jp?B?cEc=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(8096899003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?cUZld1g1K3FXTU9GRTFoeEtZV05RT2UxTWNSbW0wWHYvR0NKeDlCckta?=
 =?iso-2022-jp?B?d25xbUsrR3RjWEZXd1BUZFF3T1RwMGhlWm0xNXVlNEFvSExhZVNBTUNs?=
 =?iso-2022-jp?B?aDY1SUw5VXJEUDk3UGlZK1JFcEFvbmhjVkJRRm1tWnptaWV0SGpvVDk1?=
 =?iso-2022-jp?B?OWdOcXN0Y2dWeDV3bUZ2QzNYOTUzcUlXajluK3Arc3RYUVozbkF6Qi9K?=
 =?iso-2022-jp?B?NW8xWEpKbHJZRWEyUnViSXh0T1pzM0ZoQ1BPYUR5ekg0cGNiVGlGQ3NB?=
 =?iso-2022-jp?B?cUhDRmtJanduZjN1TkQvVkV1R0ZDQnU1SjUvNjBRNVF3S2NYK0pTQ244?=
 =?iso-2022-jp?B?LzVNYkREbVVReERJNGtoOC9oRkxnRTFmVGxZMjhZZE8weGtiMkc0d0FT?=
 =?iso-2022-jp?B?c0xOeWlKTjRyelJ0QUZkYzlGYUp6MW9PQ3VGSkNkQkxmdzB2NUpPalBp?=
 =?iso-2022-jp?B?cmFxQ21IQXYySE1PV0hxZkRjc1daTUVvUkZ0N25aeUkyUUZYemFzc1Zz?=
 =?iso-2022-jp?B?TU1yVWFwMDlMZEtiZE04b0dUZyswekVYTWEwWlhFNnlOWGt1azhOUHh5?=
 =?iso-2022-jp?B?ZHo5VCtLbFByRURUZjVKeHdvY2d2dGRJQXJPbVhFWnpjbm1BTmtoRnlQ?=
 =?iso-2022-jp?B?NjQ4c200Y1I2QkNQUjQrekpvcGhrcWM1UnlwQi9zRitrVmJtOURQWnV4?=
 =?iso-2022-jp?B?bzJoUlJveVFkR1NpQ2Y1d0ZObWRkRmp3czdWbTFFeTUzRHRCWGJRRmtu?=
 =?iso-2022-jp?B?M1pENG8ra212Vmh5RTdNTFk0Wno1TThvWlNTYjRHcUVwcFdrWVBXeURx?=
 =?iso-2022-jp?B?Y081andGbmRPSGVZZmprc1V5NkFEdU05Rk82eTRRbUN1MThLdW1mUlg2?=
 =?iso-2022-jp?B?a3pPdFVuSkpJQ0pSbDN2NFBlaE8zNEF1Zlpkc2JOeHdjaHN6YTVqRXVs?=
 =?iso-2022-jp?B?WGtMRHB3Q1c1THBJK3RhZ1pHVHVqbFZNUkM1dUc3dVQyaWhNL2J2MHFX?=
 =?iso-2022-jp?B?NUdGRU1SVU8vTC82ZXNJdmMrRUJtU0RlNjlCNjA5eWltZ3o1N1I1aGZG?=
 =?iso-2022-jp?B?VldQT3dHRFZ6aG9TMkQ0cmluREVRcjIwUk9DRFZqeXRxNnkvMkRnQmY0?=
 =?iso-2022-jp?B?S3N5TC9PZmU1RFRsS1dvelBzcmVZVkMranBoUFFSNVd5TDI0SDhoSkhz?=
 =?iso-2022-jp?B?QWFWamVab2dxNklsak1MMElPQXdFeHNuQllEcjYvOW8wUXZudENCYkhZ?=
 =?iso-2022-jp?B?OWpMRHRqZW9sWUdneWNXamFIRUs2WUlwRmN3bTJDRzVkTDVveDUyRkxk?=
 =?iso-2022-jp?B?dnJJbzBqQ3VuNkE5OUQ2NGxLSDE3bEg3Y2MySnlIYVh1RVozMnFXdHQ4?=
 =?iso-2022-jp?B?d1lySFRoRVp3UUt1b1ZPTWtyeUIyRWE3NTRxMWttNTZkK29KSmhrajdh?=
 =?iso-2022-jp?B?SmhQS08rN0dnYjdQaHJmRmQrTVVjSUNmWlV3S0VzQTFCbHhTR2d5ZkQ2?=
 =?iso-2022-jp?B?UlVLSVlCaUpiWDRQOHliRElHSWNMalk5WXdZL2xVdDV3cVpaU3pzdHJR?=
 =?iso-2022-jp?B?ZFp2Sm1KTHFnUzdkaTAwZEV3S1d2S05NR2dMcGp3T05SZnhJYUYxK1VZ?=
 =?iso-2022-jp?B?NVhuOEt3b2NJdXNIa1I5czNtcURXWjZlUUJQV3FrZld4aW90MFgxQXJT?=
 =?iso-2022-jp?B?LzNkc2pucUFGOTBOYWtEZXdSdDdCa2pqUVQ5cXBOUmtETGZSbzZZYTha?=
 =?iso-2022-jp?B?enZGM1gzT0JQYmdVOFhSRUlXa3hmQVRVOVNmZ0RIMmx3T2d4QnFId1Mw?=
 =?iso-2022-jp?B?QkpwUnpqd25OeTlYdldkT3NmRDNZVkRuVENudzZDcXNJcU9LcVRabmVR?=
 =?iso-2022-jp?B?Z05kdnJFclZyMVFFYXQwYXpqNDJKNkxLTnhCVlRSb3EwNGx6eFRqVEcz?=
 =?iso-2022-jp?B?dk5BZ3JoUG1JWXZTTGhLdUZXU01JVmVjWk9Ib09JYTJtdUcwb0tPbTVR?=
 =?iso-2022-jp?B?VzFLY0U3cnhQaThWR1AycnVLMmdQNXZmNUZ4V243WjlBWmUzTnNHNHJQ?=
 =?iso-2022-jp?B?cDA5ZkI3eDdvdjU4VjJjTlplWktuS2FGcE5oMDA4czNPc1gwc0U1cDVW?=
 =?iso-2022-jp?B?eWVDazhlTEt0K2k0ampEcnZjaEw4VDJnV0JYd2RMTWFKOEV3ZTF5Nm9x?=
 =?iso-2022-jp?B?RjQ3WDk1OFlDZFllWDZtSXdhT2E5MzBWK3djZjJsYTd5SjJpcUg0azdN?=
 =?iso-2022-jp?B?bzg3UE1vdkZMNzEwejBHdjBaZndrakcyY0ZrV3JtOVhuRFowd3ZnRURQ?=
 =?iso-2022-jp?B?NzFKRGtCbEFWUG85ZkNJUzV3RUdvTEFzeDh1UjBvb2UwNVhjWGp6TS95?=
 =?iso-2022-jp?B?TFVZSms9?=
Content-Type: multipart/alternative;
	boundary="_000_TY3PR01MB11075908DA987ADCDE33DD899C7DF2TY3PR01MB11075jp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 752aca17-d841-44cb-3a3d-08dd655ba066
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 13:57:16.3722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A/M6845SXaG+LVfaISn2JLhvFs3hlzqNkcPpSaIqjmIRPwoTE/xyX31C+NeJr1Qrz0/XXRTwJ2uDbhyrSEKmpnWQr1ThKGJELcfrvziInpM4aSf0yJ2hIu817xq9KkjJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB15055
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Mar 2025 13:57:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18232

--_000_TY3PR01MB11075908DA987ADCDE33DD899C7DF2TY3PR01MB11075jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

This is regarding the zchunk based swupdate verification on LAVA lab.

The zchunk based update needs a file server where we keep .zck file and swu=
pdate requests multiple byte ranges based on the requirement.
In manual test scenario, this has been verified by keeping the file in Apac=
he / nginx file server.

In LAVA lab, I also verified zchunk update by installing Apache / nginx in =
CIP image itself.
In the last CIP core meeting, we discussed to use some container to host th=
e file server (Apache or nginx) for this purpose instead of installing in t=
he CIP image by considering the package size and maintenance.

Do you know any EC2 instance where we can run docker container with nginx/A=
pache for this and should be accessible to LAVA lab?
Or do you have any other ideas/place apart from EC2 instance for running co=
ntainer?

Please provide your opinion.

Thanks & Regards
Shivanand K

--_000_TY3PR01MB11075908DA987ADCDE33DD899C7DF2TY3PR01MB11075jp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
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
span.EmailStyle18
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;
	mso-ligatures:none;
	mso-fareast-language:EN-US;}
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
<body lang=3D"EN-IN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Chris, <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This is regarding the zchunk based swupdate verifica=
tion on LAVA lab.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The zchunk based update needs a file server where we=
 keep .zck file and swupdate requests multiple byte ranges based on the req=
uirement.
<o:p></o:p></p>
<p class=3D"MsoNormal">In manual test scenario, this has been verified by k=
eeping the file in Apache / nginx file server.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">In LAVA lab, I also verified zchunk update by instal=
ling Apache / nginx in CIP image itself.
<o:p></o:p></p>
<p class=3D"MsoNormal">In the last CIP core meeting, we discussed to use so=
me container to host the file server (Apache or nginx) for this purpose ins=
tead of installing in the CIP image by considering the package size and mai=
ntenance.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Do you know any EC2 instance where we can run docker=
 container with nginx/Apache for this and should be accessible to LAVA lab?
<o:p></o:p></p>
<p class=3D"MsoNormal">Or do you have any other ideas/place apart from EC2 =
instance for running container?
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Please provide your opinion.&nbsp; <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks &amp; Regards<o:p></o:p></p>
<p class=3D"MsoNormal">Shivanand K<o:p></o:p></p>
</div>
</body>
</html>

--_000_TY3PR01MB11075908DA987ADCDE33DD899C7DF2TY3PR01MB11075jp_--


