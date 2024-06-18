Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB6BC27C4F
	for <webhook@archiver.kernel.org>; Tue, 18 Jun 2024 04:38:40 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.78355.1718685511600473217
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Jun 2024 21:38:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=X/2JWt/o;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1718685501;x=1719895101;bh=IHMQV/sRtYFGQqBJWAcXxaZYC4OG84EcUXLJa6X
	5vG8=;b=X/2JWt/o5wJzEdiqBeiQrgXI0i7h8nUbK1dHEHJbWRghtc+0e8wwK8LBFmfKhWrVVhIHs
	2rQVUe1qebzqRLh+qk3lWFuLANKdZ/k3erevkB6K7S38OQgQY4dIzhLZNfNjPYRiPpHp6crqNFzKh
	L0KG+LiEqvfOuRGSy1V5upfQnfA2wV0kPAJYlA5dWOjNBMTilWBQHeMqgwreabZxweLc5gsHVSYgM
	mDNaCwIpmYObh/3ypwbQPN+0SHAOFHM76N3o830a+0rNj9HSCrFYqvl5MEu3qHsqR3mNsoZMkDLh1
	OEueRz24ule5Tgdf638f+Xx2eTz3FW4sZkpRnLrcrg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 45I4cKF2632375; Tue, 18 Jun 2024 13:38:20 +0900
X-Iguazu-Qid: 2rWhclmqSP2Yg2vEby
X-Iguazu-QSIG: v=2; s=0; t=1718685500; q=2rWhclmqSP2Yg2vEby; m=GJXa+SmHOxl8UY+BV11hxS+Fy5s3UBcyYjafMUUxvAU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 45I4cIT03543170
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 13:38:19 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipHt5mFlClR/fFMGbUm7ygz2ao8dEV05h8Vuq6HPo6UDEFt/Rifw2WrOvxXecKxZ1HgRsBlq43yBoUB4XWRAI+vThfNsChFwDADOfi6A+Hw/qDH1DiIkrziuKAZPhwOQuQ0deNIScGilQd9bOcKkg7m01omSCh+kvsKYCtjSBPs+85UJXH+gyspo/VdeyHJgmFmeVI0xxSPRohZ1GCNznb/ezK7tEPkYgMhuXJm8UDHoTloSO20y2FeZdLTngV1K6OMZJouJWM7vrBodKcNNB97n7hUxK4pPqoKZ9FmwCMj3dJY2x4lzKSxnx5JvKlvYq+IWbZSVMZ+8vEcfQ0XgBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tPuHa9m+09dFdOCyhGEJswWR3ST909u37/Q98Nmt8Q=;
 b=HsMSbDmxTNdE50c2DyX42suH0PisgJMaDaKa9tHHRLghP1ZhG8kSFdNBMYeN3O/RMrKhbu7bQrl0uCvcb/McitTRFE8bTapc4KtAwX18HvsW/VeBvX640TGEwB2/H4KHElZQhsR62wuLv8lPViDK0bssJZPFsLZiM8mD+xKvRHFiOAeMUKPvWGA37qC3n1wlnZ3ZxzleHs8K75+xuvsCkjW2Xl5hTT3NT0yonHcE2E2K0kNn/5PywwXuW4rYtJL8ckxzQ5Glu7k/hz3o9Lc1j+0EEGvplNlKXCh9S+lvt6Qkno+ZIeh4IAIidBYxdfpqLAxclRwEZv7mv7KiovSABw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 00/14] Add Display support for SMARC
 RZ/{G2L,G2LC,V2L}
Thread-Topic: [PATCH 5.10.y-cip 00/14] Add Display support for SMARC
 RZ/{G2L,G2LC,V2L}
Thread-Index: AQHavkN7KszNdqmnYU+lx4QhUleRarHM9WSw
Date: Tue, 18 Jun 2024 04:38:16 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB638836BCBA440B2E9BCABA2392CE2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20240614101308.40407-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20240614101308.40407-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYCPR01MB10683:EE_
x-ms-office365-filtering-correlation-id: e8859f9b-9647-4176-1fa0-08dc8f5078bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230037|376011|366013|1800799021|38070700015|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?TitBYm50ODY0RStVZk4wSVNKRjM3dEpCaWZKTXhPY1lvSWZxemNOK3pk?=
 =?iso-2022-jp?B?ZmtUc2RQNElvRUNhempPNDZIc0cvSWU1Y2o5M0Jjc0J2OVUrUVpadUhi?=
 =?iso-2022-jp?B?WFZkVjBzWDJzTk1ITnRvR3l1R0IxUFpUTDNvcWlWOFd6cUVkNldxdVJD?=
 =?iso-2022-jp?B?b2E2djI5NG5mN1E2MUN2UzZvWjIxVWF2c3lVbE9vcWs3S2JCMi84Uy9T?=
 =?iso-2022-jp?B?ZU1pT0IzTEQrWFRXa2dYdWZ1eHJ6WjRlbTZab3BpQnJtK1NSUEowT2RK?=
 =?iso-2022-jp?B?SldQNXlWdHJ3UkVGZTdOUGMwdURNbWtiNXpybFA3UVlwWWU1RmdHUnQ3?=
 =?iso-2022-jp?B?R3hlZkFxNDMwMStlSkQ2NVN2NTlReXFoZ0FvdmtQeVB6QVpvOEs5V1lX?=
 =?iso-2022-jp?B?V1d1dXFoT0gzUFhZOHZSVC9UNVNUVnVsblZnMkRaZjI0Vnl2RndadWNR?=
 =?iso-2022-jp?B?djlpM01VRzFjdHVnbHNpMHU5Nk1wZmVqWjg0TTRpR2p0T000MGVlOHJv?=
 =?iso-2022-jp?B?eGZmVittd2tHWCtyVjdXYXJ2SEowWDdGQ0JJMlhZT2UzZEI2STJTZGVt?=
 =?iso-2022-jp?B?VHJDV1g0VkhhZnY1ZkdreTlKSyt5bVcxTFJyMDcySEdvNTVZdmZnUGhx?=
 =?iso-2022-jp?B?a2xSeng2SW1FWWpVNm01R1h1ajdHYXc3Z1ErNHpGeGsyZkZRWEdKeHVZ?=
 =?iso-2022-jp?B?NXZsN3FENXFEYklHM3BJU1NhVW5jNWh6U2ZHbVFkUzJBbkhWYm0rMFQz?=
 =?iso-2022-jp?B?UEltTlNJMFB2UGNXWFg2S1dCV1FGUy9oQ1pwOFZzZ3dRWStnL1p3Zm9E?=
 =?iso-2022-jp?B?aHhJQmp6QXgwM1RTRlduTHdhYisrWGkyOU9yK3hJRE95Z2djQUpXNnJX?=
 =?iso-2022-jp?B?enRZYW9aU1lidU9RUGtNcjI3UHhRTEo1QmNndkpXb2NMc2x4QWh3cnNP?=
 =?iso-2022-jp?B?K2lwVVR0a0R3MjlIRWhnZkpkMG5BVzd5YXhNNFc3eEFhY2NkSSt2NjJZ?=
 =?iso-2022-jp?B?eTVUcEFUeCtzL0hrMFBiZmFDYStkVmFnS25ReXROQTdVQ01QZXVNdjUw?=
 =?iso-2022-jp?B?dnd6bHdkNjNINGNhVExzbCtJc09reXUvTmYzV04zdTIzTEpvMXhWVURU?=
 =?iso-2022-jp?B?QUNoLzl6RGlSSjRieHBSSThaaDh3RnFJMk1nbGhFUmN4SVl4TlRNN3dC?=
 =?iso-2022-jp?B?REZmdzY3OHhVU1NmTXE1T2t3cnhxREtnTkZ0b3VoM0JTRDhHN0xDeDZI?=
 =?iso-2022-jp?B?dFc1S2QwYnY1QkgwNFVSSG55OW8vLzRVVTJwbGxzaDI4TzBmZHZrS2s3?=
 =?iso-2022-jp?B?MWpxRCtUWHlYRzIvcFhVZ2haZlIxTWxSdzJta1VkOEJ1TDErck1tZjkv?=
 =?iso-2022-jp?B?TTR2ZjhNTHArMEErRi9BeitPSThlUThIQ01sbFh3elFSZjlvQzZjMlNX?=
 =?iso-2022-jp?B?RDJ1SU9vNlh3Y254T3dueG5uUXpWcm5LQzEvdlZWUW93dzNHSkFGTFZm?=
 =?iso-2022-jp?B?VjZyeDJhcUlaL3dzNUVCN0wvdjlUTzg5TlMzaG9SaFd4SGRoeXhKRWds?=
 =?iso-2022-jp?B?WHpmTmZOc2Y2TUdCYWVJSERzSWR2aDZIRFNjd3prbFZpRkZCTW8wSm41?=
 =?iso-2022-jp?B?aU1rbG9mSGx4TDJRQnRBR3J4dG1DaHIzdXhPY3Jsek1MNU5jR0V0R2NR?=
 =?iso-2022-jp?B?OGdsZXBBc29kVTNBeVRwZDlZS0lCUjlwWktuVElEMWp2YkhWMGVXWWgr?=
 =?iso-2022-jp?B?OWJGU2N3Y1ExWHd3UENrUUxKaDJ1ZUd4ZGczNGVzakdkZy82cDVRV3hE?=
 =?iso-2022-jp?B?ejlpR2RxMlhtSk0rN3g4b0hpVjhOQ1lRemVqUjVTOFpSNlRFaW1vV1NU?=
 =?iso-2022-jp?B?NFhaZGo3SXI0eHJYb3Ftdmp6MG1INlZyLytmMzVEeTZSTkhDRU1pZFN1?=
 =?iso-2022-jp?B?M3ByaERtQ3N1NnM2a0JTSkphdU5oTHhDYmVnWnMrbVAxVUUvWGlUQ3RG?=
 =?iso-2022-jp?B?Vk1XU21oYmdDUHN1ZFNlY29nRHpPa0RqVlRoMDJ4V1MrVGxPVjVYczBF?=
 =?iso-2022-jp?B?TkE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(38070700015)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?SzQvd1VKWmlGbzlQTmc0ejBRenFKeEZhYWM3NWpOSlhOc2VPdG1DMmRM?=
 =?iso-2022-jp?B?bHZWRkNOMmZnOHhxT0prZ2djMFBIY3REL0FFbkgvdGdjZ0VWazgrOWw1?=
 =?iso-2022-jp?B?Rnh3Y3lZbDhjUWowNDdZS2hVeFQvYjhBd1d6SXd5R2J1MThtRklXMm1K?=
 =?iso-2022-jp?B?d290TXN3RDNSRWpQU2pSM0wxN3U5TUJlTlR3b2NzS0hHWWRqK3FnYU1q?=
 =?iso-2022-jp?B?cFdSSzJMTlVOVGlmV25mQzF4cEt0ekFIWEJqSEViM1pnTHNqU21MZDhN?=
 =?iso-2022-jp?B?cithWDZ2SzJGK0xjdWRqT0J5V01jU2RhNnlCWDh1UXVLM0Z0UmovN0FS?=
 =?iso-2022-jp?B?NDBzWkJ2ekEwT2lRRkJPbDAzaVhhSWIwQ2NtQUJlcVNIL0h2cVYvbFlo?=
 =?iso-2022-jp?B?ZG5JM0s4WkhlOG1waDNqRzZrbGhEcDkzYm9kcHRMWjlnQUJreHVwUjlB?=
 =?iso-2022-jp?B?bTNYMC9XMjBJd2JOR3VSSHQvb1NTRUtkNGp4eExSRTdmUnBGNGlRNUpn?=
 =?iso-2022-jp?B?STQ5Uzd3ME1jbnBIR1N0Rk9yZHhzV0FUMGl1MUFuT0NFVllJVnNTdXY4?=
 =?iso-2022-jp?B?QVBuU1hSOHZKV2ZHUmhUQnpwOWJzTmk0dXE4M0xqNTBDWjlUN1MyU0do?=
 =?iso-2022-jp?B?Mmx0L29rSVVMWDh1Nit6MUg3V2J4eGFQVldqdkEybkoyQ0ttUmVNenJv?=
 =?iso-2022-jp?B?R3VIQWExd3N2Z3MyS1lkMW44VnlIdnBlQWRFYXRVdnpIMU5lMjhyN0Jl?=
 =?iso-2022-jp?B?VEU5ZDZYaFpGQmtoWnhuVEQ3eWxqdE9ldkZUNG4vYU5mOEVlZE5ZcG5N?=
 =?iso-2022-jp?B?a1hBLzJucmJUSHJkZi9NcndRMTAzdlo1elhRQnNlNDYzRFM4dldneDhh?=
 =?iso-2022-jp?B?ZEFCWXVHSE5PRDBZVnRENGgzcytVL29weDA5d2tOakdrcHB4NldaZmlX?=
 =?iso-2022-jp?B?UjNtVUpsNEdKb2RmTlhRRDZpZXJsQTJaM3BnQWhsemgzS25zRndHQ3VY?=
 =?iso-2022-jp?B?NnNWM1FINWZsRE0zWVpLN0M1Z0NreWpZSGlPTlU0VGpPckRhZVY1Y3ps?=
 =?iso-2022-jp?B?VkNxeWlSazE5emptZG5OQndPaHptcFNIQ1pIbnU4T1V4WXgwUHArNCth?=
 =?iso-2022-jp?B?VlNIcEdyOTg2ck94bDlsYVdCb2RURE9mRkd4cGJlcll2MGR4K29Tdk1m?=
 =?iso-2022-jp?B?RjNwWHJLZzhzT2hIUks0MkVoNDV1UmNoRVorZHZlNUwvazZ5eVJiL0s1?=
 =?iso-2022-jp?B?K2tJTTlHemc1aW9MdWEvQk1yNXNrVHB4UUJTMmhNVEF2TVU0WXVaVXlm?=
 =?iso-2022-jp?B?OWI4UTQrWmFmSFFrOUZBSHVvdWk0Mk0zbUlzREZhckhMbUY1VGpoQmhy?=
 =?iso-2022-jp?B?K2ozOUVTN3JGekQrTWlXYXozSDVKTjF2TlZYMFYraHJyYUlOL3d6UGN5?=
 =?iso-2022-jp?B?ZHozK2lXZ1QxemNqNGZOSmhXWGcvTFJSeTJGa29SVEV5YkVZOGo3Ym9k?=
 =?iso-2022-jp?B?aXBId2gzZ0hmdmVGTTh2bEo1UGNSczZuYUNjeDVSYkVlNU85K0RSdEhs?=
 =?iso-2022-jp?B?YnAveVpKM1Brd2I0bG9pYUNlc2EycTQ1QVJUKzdWMFUxaHpnaklMM3dY?=
 =?iso-2022-jp?B?djcrbnFHMlhpUHBKcHptL0Y3RGFBaUVSMG5vQ1o3RGhhZVBxRTNmNWhh?=
 =?iso-2022-jp?B?bEMwTTdwcHdaaHVUQklhdnJGYis2WnVPaGJXMEVNcytDaTIxQW43RFh2?=
 =?iso-2022-jp?B?RW9JYXpGME1VeGVtTWVjRnJhdGxFY3BsWFQreFRuSzl5L0M3Z0pycnc3?=
 =?iso-2022-jp?B?RHQ4ZFBOTDRvSHJJWUdtVEZKellXc29FSWgxbmpJR1M5eGVqbU1zM0Zi?=
 =?iso-2022-jp?B?amNVSHB1M04rL1hJei9STHhBN3V4dmNkSCtXWndWQTIyNkVDTXRLYVBM?=
 =?iso-2022-jp?B?WCtVR1VxNit3WHQyVUpJUlU5TXZ1dkxha0VsR3UxcXlGeE5nVCtlQ2Uw?=
 =?iso-2022-jp?B?YlBOOVhieGpUbklFYWJlL3RXcjJZM1BLdVNTaVJ3RUJQMDNKcmljbGEw?=
 =?iso-2022-jp?B?ckJMMTJJNEFlYnAxelgwZ09hc3VRRmxkajVZcDBpVHhsR25GaHZFK3JE?=
 =?iso-2022-jp?B?V3JQYzdJNFk5QmhFWGJ4VTdsY0RJcldyaVlMUXN0R29yYi94bzBvMHRW?=
 =?iso-2022-jp?B?a0taZDg2NFFhL0VmOUlSMGNISmRGRXU2Smd4UTVuRS9zMWdlK2l2NWpk?=
 =?iso-2022-jp?B?TjVIOE5sVW5IWFlEcm1PN2NwMGNGNTBhMnJmZHhUb244Y2duTmMxMFht?=
 =?iso-2022-jp?B?MGc3SUpLQUloUWZ3N3MvTmM0djYrNG8wWlE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8859f9b-9647-4176-1fa0-08dc8f5078bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 04:38:16.5371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yw8X1EUaKyfq08h6ONYhKzTc87VznXRSA7ijeGSPeDYPRxSYiysgree8b3IA+2TI943CAxknHjtWfSw4Bp/jqFVYdVdaq15wOtgFqIfnvpQFUy9oTlukWd0K7Hs+bv2X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10683
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jun 2024 04:38:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16269

Hi all,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Friday, June 14, 2024 7:13 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH 5.10.y-cip 00/14] Add Display support for SMARC
> RZ/{G2L,G2LC,V2L}
>=20
> This patch series aims to add Display support for SMARC RZ/{G2L,G2LC,V2L}
> EVK platforms.
>=20
> All the patches are cherry-picked from the mainline.
>=20
> Patch 1 mainline commit does not include some files present in 5.10 tree,=
 so
> manually moved across.
>=20
> Adapted header files/KConfig changes for 5.10 kernel in patch9
> (0009-drm-renesas-Add-RZ-G2L-DU-Support.patch)
> similar to rcar_du abd shmobile drm drivers.
>=20
> Biju Das (9):
>   drm: Place Renesas drivers in a separate dir
>   dt-bindings: display: Document Renesas RZ/G2L DU bindings
>   dt-bindings: display: renesas,rzg2l-du: Document RZ/V2L DU bindings
>   drm: renesas: Add RZ/G2L DU Support
>   arm64: dts: renesas: r9a07g044: Add DU node
>   arm64: dts: renesas: r9a07g054: Add DU node
>   Revert "arm64: dts: renesas: Drop ADV7535 IRQ"
>   arm64: dts: renesas: rzg2l-smarc: Enable DU and link with DSI
>   arm64: defconfig: Enable Renesas RZ/G2L display unit DRM driver
>=20
> Daniel Vetter (1):
>   drm: Allow const struct drm_driver
>=20
> Maxime Ripard (1):
>   drm/crtc: Introduce drmm_crtc_init_with_planes
>=20
> Philipp Zabel (3):
>   drm: add drmm_encoder_alloc()
>   drm/plane: add drmm_universal_plane_alloc()
>   drm/crtc: add drmm_crtc_alloc_with_planes()
>=20
I reviewed this series, I don=1B$B!G=1B(Bt have any comment.
I can apppy this series, if there are no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


