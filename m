Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B83BC7EE23
	for <webhook@archiver.kernel.org>; Tue, 23 May 2023 14:00:10 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web10.23667.1684850400940916609
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 May 2023 07:00:01 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.156, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 34NDxxHM025211; Tue, 23 May 2023 22:59:59 +0900
X-Iguazu-Qid: 2wHHnX26CMUrLqEsBE
X-Iguazu-QSIG: v=2; s=0; t=1684850399; q=2wHHnX26CMUrLqEsBE; m=vlFRSrNuUCBRus0N8/jI7rKAN2+lVoQLOabxmY/dNhA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1112) id 34NDxwjm016561
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 23 May 2023 22:59:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdKLVuyC63BcOYmoqDIuwGnOPWJQGZx+9OWnAIkOYNtjDvwAryyXrxFCW94OQxQoKQxC9gLBtuSktUcRavB7o9PARWzfJnz3LCgdeld61fb8PB0QRVO8eHApJduyOO2cVl8P/NY5wW5fVH4y96vpFEjW8PtZ0MqAna9MjItDpd8/hJHQfMMjlLg4cVuIMIgm7dGfX1hB3/d71uM51HZOOue0q/Mvp8sZDXCOUnmfXFjDnfBKVR2r9bD5uMnet62butpIdfRMFvIblzuygzqs/nQ8UeV6C5dZKBnXAqynez0edkutXeO4nzEv3m0hRzkP5Kwg3dSXR233MCgIZzfJVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/EnyUbtbxmWCbO+OCGGdec9AT/gfV47DaYCWlYKbOk=;
 b=JXecOPLKp8sNeUHbaD2r/kkPdKRpMD2lnMyUJQSxtC6NV66iTXoE3LXYlgv52YLP35lciNGAxWyznYQ2zaCxsc8tP/szg/DyufNoLjoPqx9GXB9cWWLfB2N0ygTjzpjGFfXX7mc1iLoOEXeRMgCdapeLUHFRFKE9bu2c6K+BNYyPulgBxhAP/oaLD0UaNK5VKxx7dHbggyzODiIrMgTW9Z+HcJSG0jZRx4YKI2yxsqv11QYNNAiDTRXbM1HjkTbgsBJwOdh6iRifMl+Ykl5YIoafJJUNEq7tONk00yusciNdjGgcL9UOefAerzuJ7Nw++qYvcem8YUqlswxrGXjC4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <Sai.Sathujoda@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>
Subject: RE: [cip-dev] [cip-kernel-config] 5.10.y-cip/arm : Add support for
 access control lists.
Thread-Topic: [cip-dev] [cip-kernel-config] 5.10.y-cip/arm : Add support for
 access control lists.
Thread-Index: AQHZh//QvA/M4ylrQk6wWyIzwrQdwq9n6DjQgAADsaA=
Date: Tue, 23 May 2023 13:59:56 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420411BB5BDF7716CF9786A92409@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <175FA4DCAB651D48.20583@lists.cip-project.org>
 <OSAPR01MB4945DECD50FBBE641129B4C3C2409@OSAPR01MB4945.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSAPR01MB4945DECD50FBBE641129B4C3C2409@OSAPR01MB4945.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYWPR01MB8589:EE_
x-ms-office365-filtering-correlation-id: c2b05293-b628-4768-7602-08db5b95fd81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 o+HwQmRvjSWWhlQBrCQXUO8/XKxqDjbaG7kLsMlTtaKM/AapjUYRo7SRJap44mImXIaCU+n00/VS6lK0RdwJ8/R0csLsillGttaRhqRE7aHZoeLwnjy3EoCqk9XTvNXfFkQoXMojZ34tV2+B8rEjgT7sd9Q00nGN5CGCxPbVtEFDINQOSNlgzULbqNjVZLfCezq9nGl80R65CxklzqimsTCcSqse+84ItkaVnwJYaxEt3lYoN+1AneToUGSvhMUXqCB3bRPjY/3pjCCaS9zfamAceUiKPnKWRxTLWq3YcboUpH8No5ePr6NwjD6+OL9sukc/zkNXITyageYhSgOqa7Ckz5VybKS/teEmr4aHOyUJ15izmCLw7a8aMd+/PP+Bf9W7Fv2LsQ8Y8G/dvsKaEVrzsT1q5pqLiFYYDr4oq6o44MiIztpWGnD8Y2v/Hmn+aJ8PtGe46HBvWreXAGRazmZn09xGgXT/8yjMWKjHLxxz4oiPkxQCxBpwpAJkglMDxbO06vpk71u/yM39/OKWH1a5d87NOOR8FF7okSokkvSZ96Ix/eO7BqkaBPRNvN53iFwP3AIbBx8oh5oh1s/7HLBkPFxsy7F+TEVk+ShBcInHMyyLjZKHKaZwCibde2uADRBxZWxjOsBzfQvZWCv1nA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199021)(71200400001)(8936002)(8676002)(5660300002)(55016003)(52536014)(186003)(26005)(9686003)(6506007)(41300700001)(107886003)(53546011)(33656002)(83380400001)(38100700002)(110136005)(122000001)(478600001)(86362001)(66946007)(66556008)(66476007)(66446008)(38070700005)(64756008)(76116006)(316002)(4326008)(7696005)(2906002)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ajZGUjlBZVMzcmJPNTdhdTVxMDUrVWJCVElqMFpCOU84VnJ5UkhJSSs5?=
 =?iso-2022-jp?B?NXJKRXBtTnRUbUo4K3JManlRL25kT0xMWnM4ckJ3TFl3MnJpbWJSbThh?=
 =?iso-2022-jp?B?dmNuSS9kTGNSNndJM29UNmhGMHZNZ2YvQXZuRTBqTm9qOVpMS1NadE5N?=
 =?iso-2022-jp?B?N2dVWW9HYXBBb1lrUUd5WUZOYzhwQlhwcUkwSEFPTGhtRUUxQTV0ejNK?=
 =?iso-2022-jp?B?WU5KNE5VbE43OG0rZ1VmZU9FYzQ1dnJJcGpHMDNuQzZHZ1ZqbE5QNmcz?=
 =?iso-2022-jp?B?SlBhYmVvMnUzOHQxRTRQK0IxRnU3UkNOMTJtVk01eFBVNEMzeTFERS9l?=
 =?iso-2022-jp?B?OHRuYW9lQmY1Q0gvNHQwRFliQndKS1FSUis3ME80R0xDSFdrdHJPbW15?=
 =?iso-2022-jp?B?cXAzRW9OWTBRNnE4ZkE5NzJ1bDlmL1FibmpLVzZFZmlUVUNnOVh3Zzkw?=
 =?iso-2022-jp?B?TzJlbUtUL3V3UlB2Z2I2WVQ1YXMwOXIrWFBJaWcrQ1NjT1p4TGl6azVN?=
 =?iso-2022-jp?B?V044dWRxejI2MitSUThhUkRKczdxbWtrOWoySlFPL2RoSWEvU2V2UDlK?=
 =?iso-2022-jp?B?VGxjWEN0ck1OdytUUlQ3b3ViZTRVeEs2eTRoTnF3QjNVUEIxOEtiWFYv?=
 =?iso-2022-jp?B?Y2I0cHVtdlMvRHZpVVpZVFQwSCtZMXJjSU5pNmkzZm00MHNwVytXcDZS?=
 =?iso-2022-jp?B?U211T3BEbnE4U3N1NzR6dDdSckhiYTBveWlJRnRpYldTMklScWVZcW8x?=
 =?iso-2022-jp?B?VU9GOWRkWDZnTXROek1Rb3czWEdDQXpZMllOcmZJWS9tQmtEd1JZa004?=
 =?iso-2022-jp?B?R29oSkNBOXRhZEF4cWdnOVVJNVAxQi9qRTFCTUhrSHpXcjNBTWo0TkFM?=
 =?iso-2022-jp?B?TkVGOEt2YVZEdkcvVUE3OTJIV1UwOHVrZ1kxNi9VUDVpVEdpUzM1cXl6?=
 =?iso-2022-jp?B?Uk5JeHg4SGRQRkdJOFlxYVNsVFQ2ckczTG9kNkhXK0tzZFVnTlFaRmQx?=
 =?iso-2022-jp?B?UVkweVEvZEp1WVl5QkRNQVo3SS9pOFN2WjJ5N0U4UEZKTTR0Q003bE83?=
 =?iso-2022-jp?B?VTFicnhNWVdsME1VZmFvejFBR3RSZWU5cFNhZ2NEY3NJVHBxaHdRQjVJ?=
 =?iso-2022-jp?B?NVpXdnNBc2xDU2lvQlhFbjJCMDkvajYzdXNkclNhKzFWbjExQVRaN0Zu?=
 =?iso-2022-jp?B?RTBHOWhZaUVtaW1ESVEzbFc0dlBBOWE0a2llNlFHaVpmeVBPdWpNcFpX?=
 =?iso-2022-jp?B?Tm4vMjF4cFIzKzlFWFlPK3ZjUW1NV3dGdDY5dytUK3ZGekMrcFJhYjI3?=
 =?iso-2022-jp?B?VXZUblp1ZXlidHJGL3h6azZGL3djVHpBcGdqSW9GVUF4VzlrL3F3UUhI?=
 =?iso-2022-jp?B?UzUxYUZLL0N5S0Z6bncwMWdMNGhxdERTUW5jL3QwM2NQb0RUTy9lNFBS?=
 =?iso-2022-jp?B?SmhRM0c4T0d0cVlvcUZMblYwVlhXdS9HTlUzS3VtcGh4Ly9TMDQwTElu?=
 =?iso-2022-jp?B?ZjVJblVHenhhRWtqTVNVYTZmVGlWaFpDOUJDN01KRENiclNJUmZhWnJ5?=
 =?iso-2022-jp?B?NFFldVV3eWF3YmRZMHl4SWQyUGNtbFJkMEVkaWIwUWRNbzhyY294S2No?=
 =?iso-2022-jp?B?d2w1NWpaYi83b0hzVkZSNzkvempYQTBFcWZOS04xODZzWUdyeFB2SEVG?=
 =?iso-2022-jp?B?YXBNZVNRRFFZUTdMcTRtbEFOa290allBS0EzSmZsVHFWZGNkNWZxbkFN?=
 =?iso-2022-jp?B?UUxIQzJtWURJWnJ5eXRwckRyckV4cGVoRllWT1RIeUErTzVZTEpZM0Fo?=
 =?iso-2022-jp?B?SFl1RWRMUWIrZW53R3BjVWRTelNVZ0lKUFVHOGlPZEtHK2Y4cWtiM01h?=
 =?iso-2022-jp?B?WGdncU9rSUZKMWNxeWpXbTNYMWNWYXRKUkhVVkdzM01najMyZXAxdHAr?=
 =?iso-2022-jp?B?R3BMc1cvUlFUcU5OMCtUejFzY0dZMVQxeWNSVXJ4bVNPQkFoRmhWVTRI?=
 =?iso-2022-jp?B?TWpTSFNnSXk2ZU5nRERJOUJUTloyLzdIb3pGc2xwT0d5NWFaeXBDTGdY?=
 =?iso-2022-jp?B?anc2Y1lVTzdmWDRuVmcwWU9NMm5FRG8rTTMzYjRWaUEveVdjMTV1emJo?=
 =?iso-2022-jp?B?UWUvTmtQNmJhWGZNWFhtb2ovRFhlM3V2aTFkTjNSK2tDU0RGUkNPVDZl?=
 =?iso-2022-jp?B?Njk3Wm5VVVNMbTV0YkQ2VkNJRHNjZVpBb29MQTZrTTN4MWNvblJSTytj?=
 =?iso-2022-jp?B?REVMdVo5eEJmWmZRWDhZRzlUV090RksrUThxWjlVUm1wNXdEUUxCdkdC?=
 =?iso-2022-jp?B?d0VFU0hUNE1DckJRMW9zMTE1QVZ0VExONFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DooAz/6ymtTk8yBiiX5C9WIAnlZLYf1+hOeZLeKb/ZpgoAPuKwBErfYDryiRntBdOo6/xNRST9LtvaH5874YGwGEiETXLpLBYH7YD2NuhgneWnT/B7IUksT+NmZRBKSENQrxmfFahX+XPu1gGFVs3FukoQHVU1kCCYsnANTE3OL+owDWye2x7LqQ4JKVv0BgNMgtPAXGMjqkty+W11VndyO6U06Sv7pHlKQNwLKUiuCZr9r1pmuAO0CGlm3i1RIY43xRj7ZOq5jV8vQzbp4njxKUQFoiDqMbItEk3WbhjFK3RjTi6AaJvxkjUw6BlSfX9vXKh7cv1H88HSS5aHCWRhXsbpLN6Fe/WIwGmLwStk2hygvuC5NdLOPuWhxxoZqvMbg7ttuFohd8vxHuHeJ/mfJ2ULf6du6ljdlVfUMIbHzCm3Ne4baZTkIaX29gqVj27jlmfg55QvM3sGSZWGc6lwFb4Bf85fgOwSgDRKGEXnsTIqg7Lwf2F/FtZlfOISsVxmwVf9Y8HfRYo9gIVAzTri44KFWTdxXii4UOeBbjGEVL3/iW6NDSekzyJj8F4mG/pz3cakCaP5+Yyen7qfY1dnvuP8XoTiMKiWbZAgjmCE82ONgBqkdFOC4+tp8K2fXXgVA22Jjew8CGAQPNhzO1Bv9hlH+OPxSF0KrVZTZ9JQKQnPGBNwQ0kgDuxzEtRAljQ0y/ulieTxyzfh+SLEQKwBkg5NRF/BdQ1Fq9Ui9akKAxuF3H3XTCxT8vInUnwb8qMJzVQqDr69/PxBr6itX8M9u/tkG1Tvxj/53F71o3dVtfomrlkan1haZKMNeXagje
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b05293-b628-4768-7602-08db5b95fd81
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 13:59:56.4411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LWmVWXu5VymOHt0rqHgZEA0O1Ald8WhbNDigzaOUPm+bn3Kq4otuRynSNpO8KSMyVO9oP0fU71QLjy3M3D5tDLGUFJsif/sAIHpD0wuWtMs1j6MuTcDAC4D1iCVxBv/7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8589
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 May 2023 14:00:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11617

Hi ashrith sai,

> -----Original Message-----
> From: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>
> Sent: Tuesday, May 23, 2023 10:48 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting)
> <dinesh.kumar@toshiba-tsip.com>
> Subject: RE: [cip-dev] [cip-kernel-config] 5.10.y-cip/arm : Add support f=
or
> access control lists.
>=20
> Hi all,
>=20
> I request you to review this patch. Previously I sent a patch for acl pac=
kage to
> work in arm architecture (IEC purpose) but in that I mistakenly added ext=
4
> related POSIX_ACL config.
>=20
> Sticking to the purpose of acl package to work, In the below patch I rect=
ified
> that, and just added already existing EXT3 filesystem's POSIX_ACL config.

I see. I applied, thanks.
>=20
> Kindly provide your review.
>=20
> Thanks and regards,
> Sai Ashrith (T S I P)
>=20


Best regards,
  Nobuhiro

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of sai.sathujoda@toshiba-tsip.com
> Sent: Tuesday, May 16, 2023 7:37 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>; din=
esh
> kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip.co=
m>
> Subject: [cip-dev] [cip-kernel-config] 5.10.y-cip/arm : Add support for a=
ccess
> control lists.
>=20
> From: Sai <Sai.Sathujoda@toshiba-tsip.com>
>=20
> This config is required for acl package to work which is used for IEC-624=
43-4-2
> evaluation.
>=20
> Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
> ---
>  5.10.y-cip/arm/qemu_arm_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/5.10.y-cip/arm/qemu_arm_defconfig
> b/5.10.y-cip/arm/qemu_arm_defconfig
> index 58ca273..b8f4e88 100644
> --- a/5.10.y-cip/arm/qemu_arm_defconfig
> +++ b/5.10.y-cip/arm/qemu_arm_defconfig
> @@ -149,6 +149,7 @@ CONFIG_EXT2_FS=3Dy
>  CONFIG_EXT2_FS_XATTR=3Dy
>  CONFIG_EXT2_FS_POSIX_ACL=3Dy
>  CONFIG_EXT3_FS=3Dy
> +CONFIG_EXT3_FS_POSIX_ACL=3Dy
>  CONFIG_AUTOFS4_FS=3Dy
>  CONFIG_FUSE_FS=3Dm
>  CONFIG_OVERLAY_FS=3Dm
> --
> 2.20.1
>=20



