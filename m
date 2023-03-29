Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFF4C6FD18
	for <webhook@archiver.kernel.org>; Wed, 29 Mar 2023 22:39:57 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.133])
 by mx.groups.io with SMTP id smtpd.web11.11841.1680129590129366074
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Mar 2023 15:39:51 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.133, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 32TMdeE1026137; Thu, 30 Mar 2023 07:39:41 +0900
X-Iguazu-Qid: 2wHHJG9eMXOS8RvpYI
X-Iguazu-QSIG: v=2; s=0; t=1680129580; q=2wHHJG9eMXOS8RvpYI; m=e1Ol7REib+X2bateJzFSO2eJKjT3j2xgScePmyzacoY=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1112) id 32TMdcNB004388
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 30 Mar 2023 07:39:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGIfLkLahUSYmx1o3n+pOlEsWbt38EOb2xmoZgcQU27ftjcwP4k05RzhR1oVYJCVy0dElmuqv5D32ZnKF9Yxfe19PfQd52+oiMbTFFZhuIF2m8bOfwOcJXRjNUa+ZV138dZ1zpjtxPHgTD5PcHCFAYYQoJptuKGlbUrQ37O72EMAsHymVc2iJ7aFDwm3UuEP3AN3QzmeysVrYIiYe8IPx2YtKkoj5u+K6q6jtz6H9ZOcRMoxfs2zkZPqhP4R5sUpUDhkwFhYWU9pMobl58qmxh4WEB+Q7q57QTfD2sd13iUGICkHezqQaIvXDMf6xvZzrBlWr+j/KuNi1fza2ytLbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/i6FGuoR0iokrx3qfeM4NRYHBqYScUJDHkZRIslTsY=;
 b=NNTppZzMP9mA8uH2EIT1H+2lNJdYfwqj0tU0JhEq61kuQvonzr56wVBaA2sbEA7qE+9+9wWOxAgos6FIFV9L6ai1Qc3nN2y7Zmmg4RBEPReXVW2RFatU/GoGMDHCzCJue2z0TWJCLC8XHdZ7owLQ02U2aG3OBujmTdo/PdNZqYNY1ilRxU561OPd0KHUyJuAuMw+/8E9r5RvrI9kCG9yfiB6Eh2uJSRQa72Vnd+Y9/Z7sNHyWKPp0kHmBfeA+jLvi/B+GFKmXTutfQ0I9du2mRUumlbNvXvcJs5JNg1fhDLVtq1dbnYVv0/PjpBka3ihKVaY9/NoXdiT7bqmqbkBKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <uli+cip@fpond.eu>
Subject: RE: [cip-dev] [PATCH 4.4 3/3] ALSA: control: use counting semaphore
 as write lock for ELEM_WRITE operation
Thread-Topic: [cip-dev] [PATCH 4.4 3/3] ALSA: control: use counting semaphore
 as write lock for ELEM_WRITE operation
Thread-Index: AQHZXnTH0ddSNpFw6UCHJDXePBegM68SYBkg
Date: Wed, 29 Mar 2023 22:39:36 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB942097E72E616833130EAAB292899@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230324171812.221086-1-theflamefire89@gmail.com>
 <20230324171812.221086-4-theflamefire89@gmail.com>
In-Reply-To: <20230324171812.221086-4-theflamefire89@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYWPR01MB8920:EE_
x-ms-office365-filtering-correlation-id: 72687ce8-a692-4569-0b5b-08db30a679aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zXQ2U/alu0FmeqcELpYvDSxu9i2eghLSk476sflisycNS8u02WV99d2fCHEYq3gGeZdQKAfpyo4ZLCalXoy83T2zmEOJBD+rl7mQsDhtHcN1dvNT5E3QdIk5ByHGawQkmKu5dGNaE5qWFPv04j/gRxaApxX6KufE+RXeqiuwkiCKthd43a5HKvB/mmsxLUVRZplbQvPtfU0SLEKQcUiQVpx8F+tr0+Wr6HGPH+Cf+cGs2G+iQ85dpgOfRJUCiMaG+Je0d663LH3fBIGfNZ5n6VtjfeU5ZaDJ3unuiYqQhyRrKTxTz0G4Tu88rdLLs+0qL4cchWGhTBxl53bV12/yBi86MLif0oORDqLNXVtDSGdNFz8Z2H8b3hD6I6VxooKLicQa6fOEU4g0iKz2ur3WjpvCV6hW72QmQXD/UlT7/VyRVVpE+7UUEtRf9L1LhobjGTBQO9a6rpHRcFhQLMAfaQwA00BD37rxR481TObVik3TcbonRX9EbNAtyH3UXoPir2AxCLJbpXzNy06Zlf26RGQI66ugA9mExPQM2PXKq9CxEL5Fi8VR95yJkbst4m6BMB6oqUKRCcHTSp+pIl4ClwSxjurlqaVk1fm/QbqNBdFj4e8zkoqTQRCHlbgmU1F9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199021)(55016003)(66446008)(66476007)(66556008)(8676002)(6916009)(76116006)(66946007)(38100700002)(316002)(5660300002)(41300700001)(8936002)(122000001)(52536014)(64756008)(9686003)(4326008)(53546011)(186003)(83380400001)(71200400001)(7696005)(478600001)(26005)(6506007)(86362001)(33656002)(2906002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?djd5cGF4RW8wcXFlenJod3JVWjlWalVKL3FhTmI1aVBFZDZ4WXI0RFY5?=
 =?iso-2022-jp?B?Vmt0MnNZNnZsTDZ0b2tJUUtYNDBwdzJMclZMaVc3elJEbkR0Zitnb3Nj?=
 =?iso-2022-jp?B?ZE9zT2xHU1ViQmhGZUNsS29HZUx0alZYTkRJUmtUc0RUZHhxQ1NZQXBZ?=
 =?iso-2022-jp?B?aE9HTkhiYVJ6YXo1Uk9JVk1ndGdxN29jTFA5bC85dHo1TStxUnFhYWs5?=
 =?iso-2022-jp?B?K2NtajY3SE9vbVlpbTBRd0ZMWSsvNVk2eWN0b2RnZmVjL0tBWUM5UWtR?=
 =?iso-2022-jp?B?QUNrMWxhU3R2YkVYSnRsOUd4QldoSXF6OHp6cFFobE5UUUFDUm1kRnkr?=
 =?iso-2022-jp?B?eFlaQTZGS2ZqK2Z6bzRyTmtYYlRYWFY3TndKZk1JdnhPZTdneVNjMWsr?=
 =?iso-2022-jp?B?VkttNjRId3BrbWExSDlDVjd5ZWRkcGYrbVl4eWMzUnJCVUpKRmFRYnpC?=
 =?iso-2022-jp?B?Z29UYlBTL1ZUZDJnRGllbXA0WnVYZVJVdUdMZjNEM0VBWDJJT1BBdzZ0?=
 =?iso-2022-jp?B?dnF5d1cxeC9OS0NicU1DVCtpZjBMMU5iSUFkclIzQUp6eDlFYVVJaHV3?=
 =?iso-2022-jp?B?UmxKM25HYVBzSjNSZDd5dU9UanZTeUl1S1NZOWVucTRtdng4L1dsUytt?=
 =?iso-2022-jp?B?aysvQ2M5M2RlRjRFQ21wUUZKdXFpNlRCS2trbk5qVVg0N2YyUUJVZ1Z4?=
 =?iso-2022-jp?B?aTZMVjZZYTN0cDZYaVE0U01MVUlSZFVhVXUvalVBeXh6Tld1QzFNV0ho?=
 =?iso-2022-jp?B?K1hHRnB3SkYxeDZiR1NHc3JKRVJPMG41ei9OOGlQUWZldzVXZ1hENE5B?=
 =?iso-2022-jp?B?YlllcjZCalZWTFdFK0krQjg4cmJyVTZqQnFtb0lmSTFhdVBKOWpHK0lv?=
 =?iso-2022-jp?B?ekpKVXRZUFZzWmlDeGVrTk5QaUwwZlJlN25UQVJSTThmY3FjUTlrcUJy?=
 =?iso-2022-jp?B?TGk4VmRsRTJOeVMveW1qMmk5MGxweXQ1MGRsUDlCVjRCdXhDY09rOVhM?=
 =?iso-2022-jp?B?Zkc0b0FmcWdFTUR1RFJCT3Jkdk5ScEhURFo2TGRCSXVqNGgyRzA3Rmt1?=
 =?iso-2022-jp?B?dkhHMklCYllpS1lIa1Y1STA3V1N4YTFrWmExSXpPSXphcWlmaEFVMXB1?=
 =?iso-2022-jp?B?YSs4SDdZTnVOeU5ac3U3aXFNdEhTOGpmUXVrMHVYNEZlTTVXM29tUjhV?=
 =?iso-2022-jp?B?a3BkOWg5ZEdjSGFjOUpXVU9hR1BqYkUzUlZzbDhhV1E3c0p3RVFzVWFI?=
 =?iso-2022-jp?B?aWVjbVByakJSWTNsSlY5QXE1N0l6N2dhQjFhT1VqckVsNUhONHdldTJB?=
 =?iso-2022-jp?B?bHpWaW9HVTVTeEk4VVM3K2RoMEhRUnllYXFhUnlLT2FIR0NoaklVdExT?=
 =?iso-2022-jp?B?V0VKTXBUNm9PN1pESWhkNW8vdWhkcG0weEl1eVhVNWhxcUhHUU5MZkNO?=
 =?iso-2022-jp?B?ZnVZRHlJakVYWnVtbWdwMTFRT3RBZE9FWk5RNlMzd3pEdVFoOUU5UmZQ?=
 =?iso-2022-jp?B?NWRIZ0RiN2o3Q1NCRDdxYXBOUytMVXhEek4xSHQ4dTBBRExPRmZ3UnRJ?=
 =?iso-2022-jp?B?VTZ5Nm9EejBIb0dKeGw4cHpMQ0tONjVqRVFDVDNpamJZamlhakxjQkd4?=
 =?iso-2022-jp?B?d2dEb0t4WE9TaG1YZ1BQd2xSODNUOHdpSHU1SEU0MnB0cGtzVjR1Nzd0?=
 =?iso-2022-jp?B?U3k2bHpuWnRpNWloVC9oc1d3aW5OeGJ1aDVCNGUwQzZTME5kOHU4SDFP?=
 =?iso-2022-jp?B?U2NmWkxKVlowb20zbW9NMnA4UjJqQ0xxZlJoNk5LSFlCN3NURzgzTmtH?=
 =?iso-2022-jp?B?aWtMa2lyUWk0UDRRdDFuWHp1SjhZSW5BVUI1ZWcwWlVrMjFjWWg3eUxr?=
 =?iso-2022-jp?B?UWdQR1UyQnM3YUNKQmtCZ1orb2MzaFM1bjJIY08zNmhTbVAvRUM1Tmha?=
 =?iso-2022-jp?B?OWRHemJnNWQrNFU3VW0rbUUwNmFKZnBiSWY4eWU5d2czMXJlMXZnSDND?=
 =?iso-2022-jp?B?L2ZpVE1pVUVCZEEwczNUeXhCWU16d1plbksvLzFlQUNsc1hGMjFwdW9q?=
 =?iso-2022-jp?B?VVpsUTN3TkZxWC8yV3pScSs1ZFZRc05TT05FU2JRY0hLNFhPSk1SSGNL?=
 =?iso-2022-jp?B?M2lNSSt4amttcUFnbExjZkN3OFJJY3FXNUFtU2VwZXFZQVgwekFqNUxN?=
 =?iso-2022-jp?B?dkVGOWhBMnR5Sjl6c0xVaFBSMGVKSVFaakhZa215eVA3Ty9xSGtDV2dv?=
 =?iso-2022-jp?B?aG9UYjJyWlppOHpDWlRwZVV6a2t1SS9NdEw5RitmMkptc0JhNmt5TDE4?=
 =?iso-2022-jp?B?em1jeG0yem9MKzhCZldhMk1SYTdIUWszT2c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72687ce8-a692-4569-0b5b-08db30a679aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 22:39:36.6397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M7//m+rpgk734oWBI4Q0lGf1M+W0cKcpmqTJZRkP7JjIygGVQBx2C1NiDwHrnhFrznQjj7aoGbWNhagNAORP3XqyKYibNrCOMWtl6I7iHSf7P7a1gNWqmCuVJKZ7AqrK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8920
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Mar 2023 22:39:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11132

Hi,

Thanks for your patch.

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Alexander Grund
> Sent: Saturday, March 25, 2023 2:18 AM
> To: cip-dev@lists.cip-project.org
> Cc: uli+cip@fpond.eu
> Subject: [cip-dev] [PATCH 4.4 3/3] ALSA: control: use counting semaphore =
as
> write lock for ELEM_WRITE operation
>=20
> From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

Please add backports commit id.=20

>=20
> In ALSA control interface, applications can execute two types of request =
for
> value of members on each element; ELEM_READ and ELEM_WRITE. In ALSA
> control core, these two requests are handled within read lock of a counti=
ng
> semaphore, therefore several processes can run to execute these two reque=
sts
> at the same time. This has an issue because ELEM_WRITE requests have an
> effect to change state of the target element. Concurrent access should be
> controlled for each of ELEM_READ/ELEM_WRITE case.
>=20
> This commit uses the counting semaphore as write lock for ELEM_WRITE
> requests, while use it as read lock for ELEM_READ requests. The state of =
a
> target element is maintained exclusively between ELEM_WRITE/ELEM_READ
> operations.
>=20
> There's a concern. If the counting semaphore is acquired for read lock in
> implementations of 'struct snd_kcontrol.put()' in each driver, this commi=
t shall
> cause dead lock. As of v4.13-rc5, 'snd-mixer-oss.ko', 'snd-emu10k1.ko' an=
d
> 'snd-soc-sst-atom-hifi2-platform.ko' includes codes for read locks, but t=
hese
> are not in a call graph from 'struct snd_kcontrol.put(). Therefore, this =
commit is
> safe.
>=20
> In current implementation, the same solution is applied for the other ope=
rations
> to element; e.g. ELEM_LOCK and ELEM_UNLOCK. There's another discussion
> about an overhead to maintain concurrent access to an element during
> operating the other elements on the same card instance, because the lock
> primitive is originally implemented to maintain a list of elements on the=
 card
> instance. There's a substantial difference between per-element-list lock =
and
> per-element lock.
>=20
> Here, let me investigate another idea to add per-element lock to maintain=
 the
> concurrent accesses with inquiry/change requests to an element. It's not =
so
> frequent for applications to operate members on elements, while adding a =
new
> lock primitive to structure increases memory footprint for all of element=
 sets
> somehow. Experimentally, inquiry operation is more frequent than change
> operation and usage of counting semaphore for the inquiry operation bring=
s no
> blocking to the other inquiry operations. Thus the overhead is not so cri=
tical for
> usual applications. For the above reasons, in this commit, the per-elemen=
t lock
> is not introduced.
>=20
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Alexander Grund <theflamefire89@gmail.com>
> ---
>  sound/core/control.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/sound/core/control.c b/sound/core/control.c index
> 3ca81e85a1492..04b939df3768b 100644
> --- a/sound/core/control.c
> +++ b/sound/core/control.c
> @@ -963,9 +963,9 @@ static int snd_ctl_elem_write_user(struct snd_ctl_fil=
e
> *file,
>  	snd_power_lock(card);
>  	result =3D snd_power_wait(card, SNDRV_CTL_POWER_D0);
>  	if (result >=3D 0) {
> -		down_read(&card->controls_rwsem);
> +		down_write(&card->controls_rwsem);
>  		result =3D snd_ctl_elem_write(card, file, control);
> -		up_read(&card->controls_rwsem);
> +		up_write(&card->controls_rwsem);
>  	}
>  	snd_power_unlock(card);
>  	if (result >=3D 0)
> --
> 2.40.0

Best regards,
  Nobuhiro


