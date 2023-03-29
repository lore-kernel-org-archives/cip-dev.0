Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACD8C6FD18
	for <webhook@archiver.kernel.org>; Wed, 29 Mar 2023 22:33:47 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web10.11443.1680129223403948754
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Mar 2023 15:33:44 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.156, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 32TMXaaR019158; Thu, 30 Mar 2023 07:33:36 +0900
X-Iguazu-Qid: 2wHHmhMsGNLbKmLD0w
X-Iguazu-QSIG: v=2; s=0; t=1680129215; q=2wHHmhMsGNLbKmLD0w; m=n7+lKrVxIcFiKs1A2/qLUhEvuwdSv6hIXIq1rV/YcYI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1111) id 32TMXYxA039442
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 30 Mar 2023 07:33:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pv+0eK441n2vHq+WbPZw5JqjlwgjXETTBw7gOcL7tsO6NAhbvktmhC5DLMipsKB+8RU8Mi6WzSzggkRGAQFQ/oGM3pKcDSaJmdAZk64AuGYuOr7iNGyZ++WAZSv4Pjpxy/YF14i0Blgi5H8aajIRQ12LlHO7ltltVycItFAQ5h47fcT7PbJuv7Y8kB5b9XG3zZ/J7z/S9RvV+7shdu3udR9tq/fuZ7h2bx63xMhQxdRAmZWr+dsXSOKEYU66sKtVzBN3lXZuJpbVQu4uTMUakAvoXDG4G4gh0Ji9sMTtTTjp8p3CGdknLRLl6731kaJWCJdjpL7aVLt9cFqxor3qlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHF+zQ6ips26nhqhrZrvSR3e7OAfihwZ7QV6gfKBC1g=;
 b=RIkNidWNLg/6be8rGM4Kdlllxyqtr6O3bhlPBZKmK9y90fkBvNzirfR/q1KBRoNg8lkMq5V0z7z+iPVl76XOY5RHevKJChLJReu40Lipy/Yr+sNHCTQ+l7lofKY+s5CeBTPXM5GXgcWDqOaOgXtPiWncwk+PPr/0roR+hyKVHTPiY2h6q4G8f2DU5vp8j+5d8/1xd30Y5Dry3g9bGMG8cX50DSWqEI9fwFuruxMEQ1FwIf35H/GpbYsmdiPQI/oKlJPDfHznVKgU6Sgn2yl6rFPXSn/E5BDy2JCm8CeDVKrY+k+CLT8hjwHkVZ1ss/Qk/ZeOzxuJ66rB2hp6f83tpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <uli+cip@fpond.eu>
Subject: RE: [cip-dev] [PATCH 4.4 2/3] ALSA: control: Fix memory corruption
 risk in snd_ctl_elem_read
Thread-Topic: [cip-dev] [PATCH 4.4 2/3] ALSA: control: Fix memory corruption
 risk in snd_ctl_elem_read
Thread-Index: AQHZXnS/iWsZkO3bnEWA2LGm2eJmt68SX2Mw
Date: Wed, 29 Mar 2023 22:33:27 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB9420FE8AF97997211998C94C92899@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230324171812.221086-1-theflamefire89@gmail.com>
 <20230324171812.221086-3-theflamefire89@gmail.com>
In-Reply-To: <20230324171812.221086-3-theflamefire89@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYWPR01MB11235:EE_
x-ms-office365-filtering-correlation-id: b30599ff-a3ee-4b83-a4a8-08db30a59d8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OS33P6bC6OvESl42RW2LZMtkIHP6yNnxnE7MKdBfkUgH1SpD/QPHqqpTbKxdanvUuVIt5ioSZUmKovkqIIMHCmKtX2r4odLiLhbgTdcg4aVxTHvKCIiZkWVubzVMB+r+0wZc3dmlrY/+RAGXTdqPIfb5CBUviTw6ZTLb5nARIITyailDLGUQztPXoI49BBdnQhtK3fOcw5cJwlnmRcqspUiaKhVTO48FsDBs96VvuRUauaj3kAr8lsU+QPWbfXbbw8LQweEQVxEdriKWeQhwBgd3RRQbAss/04s4dNmmM4o/rrH90xPvwzHPAAK27edjiMgEMumal1FKcI8OP80SxX5lJZj9nc9GAUkKxziFyMCx0M8S31c/BPaYZoERrMLJvSSPiCQXhaQE3Fph30eWtjR04mVWv643MX9vS3K6aadDhRWRhzKzlfFH3nnnpiw1DlDnvnsVYlnZ6QVCy3pEdQKM2rkCBNd6zRT6a//rBW0SocsrB+LfI/ZDwuWL/dmgKnUx0cuX+yhbNcGnRNeSMP0BLtF5p0Jz5H2XU6zJnpAM/QmFfJhHnkn/UmfTF3qKMbhKYGcM5bLAKlgI5IM0Hx8CvomjsH5SDimiy96L/Jk5qbvnSAas/Ln2e55OvNYX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199021)(2906002)(38100700002)(8936002)(41300700001)(4326008)(52536014)(5660300002)(55016003)(38070700005)(86362001)(33656002)(122000001)(478600001)(6916009)(316002)(7696005)(71200400001)(66476007)(26005)(9686003)(53546011)(6506007)(76116006)(66946007)(66556008)(66446008)(64756008)(8676002)(83380400001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?UUhJTDZ3a2QxWjhKU2ZrQXJIeDc2V2pjNWg1djhQYmtXblNvUkpmYm1Z?=
 =?iso-2022-jp?B?NXczM1NNU3pLQzN5MDVEN2U4NFYyZnpZVENSR3kvbUV0MnRjMzdsRVUz?=
 =?iso-2022-jp?B?S0JWaWNvWS9NaUd2SzE0d29GWUZBbGczaFJlaklFVUNOeU5IakQvTXBP?=
 =?iso-2022-jp?B?eHRtbmE2RzZhSDlubnV3alBUZTFGdkYrNlRtVWJsVlVFSmcxbDBWVE52?=
 =?iso-2022-jp?B?SG9EVTc2MDFRTVNXaFAyejRXUmMyV2Y5alg2eGlZZlg2SjdsNHQxWnlN?=
 =?iso-2022-jp?B?UXV5bDNQZFZ0ZytDYXN4ZjVHRXVSVGhYTFlXMDB0Z2QyL2hZUEJzYVQ1?=
 =?iso-2022-jp?B?K1IveUpXUmNPbFZSYTlaTFY2aHQ1bUFnWTlUSThrbGtwdm5vZkpFbzdN?=
 =?iso-2022-jp?B?YjNQekRzMjBOWjNhcXZOdFVKZFF2SktRdC9BTnN5ZnYxT1BvOUxmK0pY?=
 =?iso-2022-jp?B?blNqa3BhMVpCam9EaUplQW1tQUkxaEFiY0t4QjBzTUNNUHhqUzVrdzRJ?=
 =?iso-2022-jp?B?TGNlc2VPbGJPTlhudkhCU1oyb1RMdGJORGplNUlYRzExLzNEamcyVWdS?=
 =?iso-2022-jp?B?eWZzeHdCa0Y5QkhkcWVid1hSMkpNeWNiK2xSSjIyeFJ4UGtMQnZUMEJN?=
 =?iso-2022-jp?B?QjM1VjZaMVFVUURzc1dUbnlmQ0IxMWxyY2xWUU00anByUlFMZ3RDbXVa?=
 =?iso-2022-jp?B?V0lmQ1drYXBEaTZ5Q0tBTnlnbjllalljSURxSWY2L2ZKZnJmRVp6T1E0?=
 =?iso-2022-jp?B?K1k3Y2J1QzF3S0R6dUV5SGpyTURFTFFsVUdoY0tSQTFCWFpKNFhxWnd0?=
 =?iso-2022-jp?B?Y3FYTnBLS1FQOGhrNlRTbWc2MGU4S0ZKWTRPSG9wb1ViWFlPdFFVdkNF?=
 =?iso-2022-jp?B?TTA5WHNCM2tKbmdyR0dDakQxYk1WYnkwNU5NZ0FKYloxN3l2cnJoZTZT?=
 =?iso-2022-jp?B?V3RNRWZHRkJtZ0E0RStxOENQclM1Tllmb1VHZEVUZS9rU0NHQ1R1Rm5L?=
 =?iso-2022-jp?B?bFFERkN2YWRXU2xVbE1vMm1tYWFUTzlVSUNWWVJkZWNRY0d3a3paaWtt?=
 =?iso-2022-jp?B?MDNmVmxSekFzOGxmVk50bGVnWnJqd2hQRzFOSGJCR3ZwMDVSSVc1VGQy?=
 =?iso-2022-jp?B?ZGtrVGY4UTY0SnAwdVRXeC8yKzBHZ3htREZHZ2J5bEEzWDNDSGFDOEVB?=
 =?iso-2022-jp?B?dWZaQS9wdThVLy8wRnFPVEcxVmRlTzRSd1dmOVNOUUxIbmFkaWlnenIv?=
 =?iso-2022-jp?B?ZnI4VHpLZzQ1SlMyK0FzN0x4VTdEYkVteC9DT0Rhd3poZnBPV2dlTXoz?=
 =?iso-2022-jp?B?Q3ZQSThxZ2dqTjNiTGUxWjZCVkh5V0UrUk1jRzl6OVFWYjNXZ0MwdHM4?=
 =?iso-2022-jp?B?RFptTmNmU0RZeS84TG9oOUFDRjlhNzEzem5tampqclpoTm1FQ3lrMWdT?=
 =?iso-2022-jp?B?MnB6Vjl5Z0NSOC9Qb2JpR01qaURvL3FwdkRoRlRVNS9ueDhKdDd3eWlH?=
 =?iso-2022-jp?B?Z2xqejlEWlpyUCtvNnVlblY4di81amtYK05jYmticWxocmpKY0orczkw?=
 =?iso-2022-jp?B?a0hEN2JLQWRMWTB6NW5teDk0QjRUWTNnRG9KV3BvME9rNGRENHF6K0h4?=
 =?iso-2022-jp?B?YUhNZjdzOURRRDFtNjNGaFV5Mnkyc2JmSEJoRHZPK0VJM3hoWWpybXR6?=
 =?iso-2022-jp?B?TDRRZzBYYzVUeUZVVGwrenlXZzU3d3laWVpISmNrL3hFRVpIQUNXMVFD?=
 =?iso-2022-jp?B?aHdBSTFqdThNTk1ZSWVON3lqUC9HZUt5NmlsZ2JEMUdjektvNjFQUU96?=
 =?iso-2022-jp?B?aUdXZWM2OFdmUDhEMDk1TE5EZFBhMXVMT21mcWJqUDBrNlZEVWd0UDZF?=
 =?iso-2022-jp?B?TGJQK2I1VDhaZkhGODlyaXNDWlpTTnhPK0x5RklwTDdQNDA0alRTZnRU?=
 =?iso-2022-jp?B?UWJ0QnUxTEpYN1Vnb285Zk1CYlpyMVZ4YjZOU0pISDQxR1dacTNBSE9W?=
 =?iso-2022-jp?B?WThVejNPdVpucVpwL2drQUJNYVM5RytkRlE0SE5SbEFtTUVPUUZMRWE0?=
 =?iso-2022-jp?B?emNUNDJMTVhDTkxFMkx3ajZHU0EvZGY1ZTRBWWJqd0pPTjZFQ2ErSkdZ?=
 =?iso-2022-jp?B?L3ZxQ0RFeWx2b3VhZTZiQ2dhQ0JmbThzU0EyUkc5U0FCeFdibDd3YVZu?=
 =?iso-2022-jp?B?dGVac1E0UzZ5YW1UK1p2WlIwaTVHeUdHQWhrQ3ZTZ3hPL1FUSWFaK2ZZ?=
 =?iso-2022-jp?B?VUZUZVNNeHNUMGZGUDJFUmhpRmc4b0tqeDhpRXk0K29kOG42ZUk4OXM1?=
 =?iso-2022-jp?B?VlJjcXZiZDdvdThIVnByYmlYZW5FNVZMNlE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b30599ff-a3ee-4b83-a4a8-08db30a59d8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 22:33:27.3861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jsWY0Icka2i9jTMCafAOz2K//dq4wyFcXNICYFRGGbtZ12n9z0Pe8RGAiJVoZppdmckKcRMIhUxkSDROTGPGTghoicelKj7oriVxDTuo6pdV7sx5KMqAcA80fvyGiBFv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11235
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Mar 2023 22:33:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11131

Hi,

Thanks for your patch!

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Alexander Grund
> Sent: Saturday, March 25, 2023 2:18 AM
> To: cip-dev@lists.cip-project.org
> Cc: uli+cip@fpond.eu
> Subject: [cip-dev] [PATCH 4.4 2/3] ALSA: control: Fix memory corruption r=
isk in
> snd_ctl_elem_read
>=20
> From: Richard Fitzgerald <rf@opensource.cirrus.com>
>=20
> commit 5a23699a39abc5328921a81b89383d088f6ba9cc upstream.
>=20
> The patch "ALSA: control: code refactoring for ELEM_READ/ELEM_WRITE
> operations" introduced a potential for kernel memory corruption due to an
> incorrect if statement allowing non-readable controls to fall through and=
 call
> the get function. For TLV controls a driver can omit
> SNDRV_CTL_ELEM_ACCESS_READ to ensure that only the TLV get function
> can be called. Instead the normal get() can be invoked unexpectedly and a=
s the
> driver expects that this will only be called for controls <=3D 512 bytes,=
 potentially
> try to copy >512 bytes into the 512 byte return array, so corrupting kern=
el
> memory.
>=20
> The problem is an attempt to refactor the snd_ctl_elem_read function to i=
nvert
> the logic so that it conditionally aborted if the control is unreadable i=
nstead of
> conditionally executing. But the if statement wasn't inverted correctly.
>=20
> The correct inversion of
>=20
>     if (a && !b)
>=20
> is
>     if (!a || b)
>=20
> Fixes: becf9e5d553c2 ("ALSA: control: code refactoring for
> ELEM_READ/ELEM_WRITE operations")
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>=20

Space here is not required.

> Signed-off-by: Alexander Grund <theflamefire89@gmail.com>
> ---
>  sound/core/control.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/sound/core/control.c b/sound/core/control.c index
> a042a30d6a728..3ca81e85a1492 100644
> --- a/sound/core/control.c
> +++ b/sound/core/control.c
> @@ -884,7 +884,7 @@ static int snd_ctl_elem_read(struct snd_card *card,
>=20
>  	index_offset =3D snd_ctl_get_ioff(kctl, &control->id);
>  	vd =3D &kctl->vd[index_offset];
> -	if (!(vd->access & SNDRV_CTL_ELEM_ACCESS_READ) && kctl->get
> =3D=3D NULL)
> +	if (!(vd->access & SNDRV_CTL_ELEM_ACCESS_READ) || kctl->get
> =3D=3D NULL)
>  		return -EPERM;
>=20
>  	snd_ctl_build_ioff(&control->id, kctl, index_offset);
> --
> 2.40.0

Best regards,
  Nobuhiro


