Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FDDC43458
	for <webhook@archiver.kernel.org>; Tue, 14 Jul 2026 06:44:13 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4356.1784011446293577027
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Jul 2026 23:44:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=wS2AdC3C;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1784011436;x=1785221036;bh=dOuJyleW/pWjA4OI5rUAKb4SAPmOmt+drTiQR
	B/yZT0=;b=wS2AdC3CQPd8lGy8TlOMCOV9KQEdAigVd880NyJMW4/ZvY7YH8e0mMrTjXK0LJvqjQG
	Z9H3UOJZmw1Zx9BpE67nliHgcUiGysA9QR3JiMiASe4kxlAzPcS/JZ+QWVX6wxaQOgOCo/DmX7F8+
	qK6+TW+mhany1W+kaxxoJ7hTfpjkKQZzn9KugRQxKz7CRDnGp4VaCf05Ct/WY4YNQvGABQojF+IaG
	MQdN/ICOkjqoysonvbPZh/I2W7zWkyhoPI9Tv/lfETZQ2n98c0sJWqIbXcTFXWVq0rOJAi4r0ys0E
	TvHW6AKyPv9o+Tf55pruZITM1Vdw1cLOoNhfOGil4dgQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 66E6htQD2321610; Tue, 14 Jul 2026 15:43:55 +0900
X-Iguazu-Qid: 2yAbG25DUDTidoCTLU
X-Iguazu-QSIG: v=2; s=1; t=1784011435; q=2yAbG25DUDTidoCTLU; m=cNWRL9U8+gaMA1t6F0n9o1Ie3iRNor0UIEFIt29lFxU=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gzqXB4jvcz1xnl; Tue, 14 Jul 2026 15:43:54 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2K6ot58alNekIWybV6SVkO53msft6NtktrTN9ylEXmH0CejKzVBJTIC23cTB+KIeXqGlBUr7srn1ByWFo45117naQSFKTDLp2WWY0N+TzoEwaSmdAv6cuzVVCcvMLnjWn2qSPo+c1bU18LRMsbHR4Nddb06trbiEQSPK6a0oGnTaKMUJtMLrOQyqldxz1DWl+wTRLsPcvatZg+csY/6qvyiTLh2p1KTYkqq+6/9R3H+IuHmgL3TlWkfsPNqmnH1wx7wFToRFPKwV80PVx0ca7b+/+x8btNeKGDl5wjAp2T9IuTmu2C7W6JdHH57gmB6h0AHKldyTObxX9l4Dg4BeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rs2NEbqo5FMt3N5k9JZveMNpRRXeDaxxNTIi/ejtBi8=;
 b=OTTWHU035qq/OihEnm+/CLEj5+W3zMQXpEUFeEemr3cApLAYRvYFBoezhtDuyd5PGIemfk9XayI63n+XOVcNX1lnxWFqE+5gxvTBPjHIi/tmP2aeM/tLsnTPcBeZsvvKqU/eLwVmn1PBUxMwSyOaHu2C3rSPE9lJmeMJJZEIxmYOjpwoZMt8UjOQFy/gElz+Xuqnt+y1AjkK5feSMBDfT//dwaWPrrE/gDnBTdbXhixy5X8iOHPWoDGnH2j/VgyGiC10rlmmV/OQbOZXuSvF57Tt4XRgvHDyX8ObBPXypiWz7ta6676QLximbAfmFFrjcdjyibld2tFG2STYFspiJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <uli@fpond.eu>, <cip-dev@lists.cip-project.org>, <pavel@nabladev.com>
Subject: RE: Request for review for 4.4-st78, 4.4-cip113
Thread-Topic: Request for review for 4.4-st78, 4.4-cip113
Thread-Index: AQHdDheiYdyTq05k9067MIY0AY0wIbZsmw6g
Date: Tue, 14 Jul 2026 06:43:51 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148183DBD65447F3376AF43EBCDF92@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <396580511.533337.1783432236611@webmail.strato.de>
In-Reply-To: <396580511.533337.1783432236611@webmail.strato.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS3PR01MB8761:EE_
x-ms-office365-filtering-correlation-id: 5529baf6-4b83-448e-2b18-08dee17343ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|38070700021|11063799006|56012099006|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info: 
 1oeixFa90osmrZUiJqNrjMm4TMzwfi/TRMQl1/xhl7xdlubrNa/HMiurglrwpuiG4QyjAtbHsrtpKG5VZQ6XukTOoLtJt9UtXMgjeIlGgzED/OKNkZa+WRIFprRWapOAzUsoRYv0wJejtFNbuPP6uj7owq8414QUQq0lI3zlqQ/Ng3vE1bOW8kvvPqdz50rY+Ebic2V4uwyfs1TU5P98P1eZWPCv8/LsNWgw+8bVpgsdeG9h02f508Kj3xCIZOyOnoHC7srhdlZpt4Px+RWanYO3+wvqNfR4zVL7AvCxx/puFECztry+3Rf/RUn9r0dDkEbudXNq2on7RNM2w3d1oZGOdKks173uOqclF6Wt1W8w85dq7KlaHIeCNPLGx9isXcOKaSQeCyYx3R8fv0soBmDzA8vHNDh5igWKm7TCaJdZzmGrQgSqK95EwzKIpcKUXICeuJ+OuGwJZ8LHPIHI4FkREX1uQPK9LTFzTcqA6P0WFH0Y4Anp/7slOejHPshc+2IJJhFKJsxBG+1BWcZOBJ33gebr94NsgAS+Oc1kETjcvx/sQpdkgyWbd2H78gbZHNr5p+DhLJyGFPYWF2Hnw8RPJLFTjOqDoRQ/lGQC/QRERCFuWOITekGyM6OXB+paaylwW7nNZ6G83Jji+mH1EBWFt6NcQ6UPOhFxKbkfGpnStjXb74cCMQxfj4s0zBwv3wBJYmWrCfVWCRuRJ3Sj+F/LRbAvAeNuQ74N1pUkkZQ=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?MTdWRWxabUZacUNEUHlzUjVmUlU1TUtLci96OTRSWWJKWWo0R3FmUitK?=
 =?iso-2022-jp?B?WjgxS25rWjU3bnQyck1SYjlHeGRzd0RPNXRBQUVkSGhXdmh6bFBpZU1Q?=
 =?iso-2022-jp?B?RUhXRzNEY2I2MW1YSElMeW9Jbi91NXNiRkZLMUtjVGFZdnE4ZFZKMU90?=
 =?iso-2022-jp?B?bTVLVGtaVVJva1h1N3lHcHZZcXoyVWY5ZUtSdzY2RG90ZmpteXFjT25E?=
 =?iso-2022-jp?B?Y0FpU0dmQTJyelZxOTZWNGNNVjdva0Jlc3VhUEQzQ2dzdmtvdTZXakYy?=
 =?iso-2022-jp?B?d1JSdHI1bGQyQ2JZbjh6djBNZldWR0VmdHlBc3VFMzYxbkhEMkQ4cHI4?=
 =?iso-2022-jp?B?MHNPS2lZTWsvOFBwb01OQUNNZk1jOUhrU3ZLekd2QUFIMXRsNmVKVTVv?=
 =?iso-2022-jp?B?NlZXUS9yV092THRSRVMvOEZuYkNWQXh6a3IvRS9lREk5Zkd6azJQVGxC?=
 =?iso-2022-jp?B?dVFmcHpqNHBEVHZhaVNZRlFoM0RCSk9SbUwvOVJ5RFJvaGloamkxc3dK?=
 =?iso-2022-jp?B?VTFyck1zb1FyV2s1UzJyN0RqUDFYaEY5ejIvb01HWXI3MWJKU2FLMjhG?=
 =?iso-2022-jp?B?TFVrcm80L2Ira3o4V3FrdG9ER21wN2MweWE4YjdrbWlDS1pVLzcvcXpJ?=
 =?iso-2022-jp?B?eTdqU2I3TWtlcU1rSGpoa3JaaTExWWRIRGtEOVMyNTdSMk93bFZyT3R2?=
 =?iso-2022-jp?B?ZzdzenNLNlVHZVFTazdKYVJiV1dlYVFvNWlFZ0FvdEtIZGkvcVFyNnFn?=
 =?iso-2022-jp?B?VGY3SmxEWkcyT3FObzVRZWVFOUlKaGdrNUxSd1BBa21RZi9QTnBtb3Yx?=
 =?iso-2022-jp?B?QnBiSnJsUkNuc0JVMENaZzJJNDgrdTczSm9NZmtlc2VGQkhjWEVrSHNz?=
 =?iso-2022-jp?B?UjUyUVBKQjF3emp0aWtSZm54NTRsNUFWVnJqdm5ZZTdvdFNlSGd5ejBR?=
 =?iso-2022-jp?B?ZEx4MG91MER2YVN3c0Y5T0dqYmpoRHJTTi9QaXUvK0RLVFJqTml2NTR2?=
 =?iso-2022-jp?B?VjVZRGFnSWMwaDE3Q3BOVmllTzI3S2hsZzJyUkw3UHNCaUVzT0JuczFN?=
 =?iso-2022-jp?B?VFQ0alQ3a0Z1OEdab3RHRXI4UGh0UlNRWkhqWTBDK0M1VWQxempIYjcx?=
 =?iso-2022-jp?B?QnYzOExlMjMxbG9kVVErRmRZUkhOQVhGZFByaC84NDlrQTZ5VzVQRCtK?=
 =?iso-2022-jp?B?RTE2aStIN2lreThISklTcHFMeUVzZUl5bURLUjhTdGVWaUNuT0JLajlz?=
 =?iso-2022-jp?B?MElPNDJERnBObW92Q3oyMmYyTmFkT2d4ZmFsWmE3Q0ZTamdpTDBmaFhJ?=
 =?iso-2022-jp?B?RjZVZHl0ampabjVjbTU1RlRQZVJTRVVwNGJXb2tVWkZOM0NMNXAxenla?=
 =?iso-2022-jp?B?SlRJb2lLUUpGb3JQNnNsaG1EVVB4MUQyUHFVYVhFYlA2cWM3b2pUbm9m?=
 =?iso-2022-jp?B?cTRIMW5sclliQWJwaExOOTl0d1h3UUR1NmRhdFpKejdkRHJWbmFvVmE0?=
 =?iso-2022-jp?B?b3dqRG1JdEt1ZWdsWm1JdUdzZ1pTVjR4bjRRTGlleWxYL1dkbHBWSms3?=
 =?iso-2022-jp?B?NWZpc1RUWFgweW84SzJJcXkybzJvSWk1MzlzcHZON2RvRCtUQlJHUjZq?=
 =?iso-2022-jp?B?T1JqUVk4RERHNU9xOXZjSUdQemRrMU1pN0paNWR2VW5waE5VU1VDOXlS?=
 =?iso-2022-jp?B?NzI5K3gxYzJRZUFYZzVKbUIrajIvbExwUytxY0FxdEUvTjNDRXloMmRL?=
 =?iso-2022-jp?B?d011UmNqNTBhdkZFaDV6ZjlZNkJGYmdvMGtUdE4ya3A3WE9iTk83RkhZ?=
 =?iso-2022-jp?B?dmRTeHRjUEl3WFpGL3doanc2ZzZUNUxscTUyVldGYWNBbnUzYTZMc3Zh?=
 =?iso-2022-jp?B?d3dGTThGcmxIclVFNEtzeW1OWksyRmFxOVhtWktnZmxEVUZHR3hDSjlU?=
 =?iso-2022-jp?B?azljZlp1TWsyaUdpcHBVZHM4b0xjbkg2cXdIais0ZUQzeWlwRTk2cHBk?=
 =?iso-2022-jp?B?ZVVKUG1mbHVselBQSkRIeVdDODhMQ2dRckV3ZzI1MXRlSXliblVXUVNq?=
 =?iso-2022-jp?B?Nmt4dE5SNDhaeEZsOFRPQWhZTVR0ZmxJMGRLMDY1UDZCWVVpNXJWUXNY?=
 =?iso-2022-jp?B?dlZiaFVkV2trRVZiazhXM21sSDBGMlpVSlY4Y1crckdwQkhMaXFhUzhm?=
 =?iso-2022-jp?B?eDdaSDlpR2pMNEhFQlZLQ3ZkUTBsRnNFTVdTNUJZbHcrdUZaQnc0UkhP?=
 =?iso-2022-jp?B?MnQ0NU5pZmdDYi9CbVAyZUlzRThwenBLUk1VTkRRNjdnTU1RSStoUzZo?=
 =?iso-2022-jp?B?anMxRjF2cWxuVG1WZ3BsS1dDWFY0MEhYMWNrM3AyeFJIVTJVWktkcC91?=
 =?iso-2022-jp?B?M1EzWDQ4SWdMektDZHVvQmRjbldtdjJxbDVlSGZpa1N3VjZnQjI0UlI1?=
 =?iso-2022-jp?B?YzhqZm9SSUhDUDBkalNtWVV1Sm53ajNPcnRaOHZCSUlsVXRBMlllK3dI?=
 =?iso-2022-jp?B?cDVBa2lpbmhxY2g0VnlWM2ZDbHZuTWRzZTFsdUZrL0l1bUR4Q2RhVmdn?=
 =?iso-2022-jp?B?WmVjZUtYYz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	mnSA6XqW2hJnDlFQVI3ipATFTJGwMuLQtwOpR7m8SV5LjWRQwtcSmeyQYeBtXB+fOeO3WD2h9JeCqOahZHx/fgFKXpP4/JN1yMzyk6M/9LQXpfEDfV+YSKQIjTy7BRNJrXEmsMLG0r2WcyoFNUugbRz9TlIMSKd/Nb9uT0/R3mDZRSHI7cfzj2Wxc7h+K5KdMllpR8OJz2ZPU6n0QJ7sOeJZckqtsB88x0m98KdyqbcU1tE/MkVOSE1NjHlTZ6apWslZhlt2FYT+8eBbvfax+384ZDBHmSgrPLq4frSR41+JlSGH6IuHW25zBiiFP+po1mwJWct9JsBkBI9T5c0jLw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5529baf6-4b83-448e-2b18-08dee17343ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 06:43:51.1233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kiZfgjahifMOU1CXjqw0XmUgMnJORni1uYXFXOw6KCoK/Cek6lM1ejCeoZMPVOwImslRQ93TfodWg8XZoFljXwsC2RPfPNUKJTa4w5LPHfOfJ0yDBun5ke3wQJpiBpNz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8761
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Jul 2026 06:44:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23572

Hi Ulrich,

Thanks for your update.

> -----Original Message-----
> From: Ulrich Hecht <uli@fpond.eu>
> Sent: Tuesday, July 7, 2026 10:51 PM
> To: cip-dev@lists.cip-project.org; pavel@nabladev.com; iwamatsu nobuhiro(=
=1B$B4d=1B(B
> =1B$B>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B) <nobuhiro.iwama=
tsu.x90@mail.toshiba>
> Subject: Request for review for 4.4-st78, 4.4-cip113
>=20
> Hi!
>=20
> Here are the manual backports for the upcoming 4.4 kernel release. As alw=
ays
> they can be found in
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=
=3Dlinu
> x-4.4.y-st-rc
>=20
> 6fc536e081b4e cdrom, scsi: sr: propagate read-only status to block layer =
via
> set_disk_ro() a70db8dc8aa2d bcache: fix cached_dev.sb_bio use-after-free
> and crash d6dc394717b9d can: mcp251x: add error handling for power enable
> in open and resume
> 270f518e2aab7 batman-adv: tt: fix negative tt_buff_len
> b9d56f0fa7881 batman-adv: tt: fix negative last_changeset_len
> 2ea84dbb4204d batman-adv: frag: disallow unicast fragment in fragment
> 3075eb7fe5a6a batman-adv: fix fragment reassembly length accounting
> 5c81177e39927 batman-adv: clear current gateway during teardown
> 516397de58548 net: usb: rtl8150: fix use-after-free in rtl8150_start_xmit=
()
> 2c14f681cb8ca netfilter: nf_conntrack_sip: don't use simple_strtoul
> a177703144795 netfilter: arp_tables: fix IEEE1394 ARP payload parsing
> 90d4b856cc573 netfilter: conntrack: remove sprintf usage a5e1c4172bf7b sc=
tp:
> fix OOB write to userspace in sctp_getsockopt_peer_auth_chunks
> a4e3e33596f1b HID: usbhid: fix deadlock in hid_post_reset() b2df99543367b
> ALSA: core: Validate compress device numbers without dynamic minors
> a856ea763a0c8 batman-adv: bla: put backbone reference on failed claim has=
h
> insert
> 420d73ca52ee2 batman-adv: bla: only purge non-released claims
> 283a66b993a78 batman-adv: bla: prevent use-after-free when deleting claim=
s
> 1f1f946bac592 power: supply: max17042: avoid overflow when determining
> health
> 0bd353e476ab2 fbdev: udlfb: add vm_ops to dlfb_ops_mmap to prevent
> use-after-free
> e27540595d282 md/raid5: fix soft lockup in retry_aligned_read()
> 16b4cbdf426d7 lib/ts_kmp: fix integer overflow in pattern length calculat=
ion
> f03a0d998b054 ALSA: control: Validate buf_len before strnlen() in
> snd_ctl_elem_init_enum_names()
> 7d2c7f0155186 gfs2: Validate i_depth for exhash directories 06c757446f45d
> rxrpc: reject undecryptable rxkad response tickets
> f842b70abca24 wifi: brcmfmac: validate bsscfg indices in IF events
>=20
> Thanks for having a look!

I reviewed this series, There doesn't seem to be issue.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

>=20
> CU
> Uli

Best regards,
  Nobuhiro


