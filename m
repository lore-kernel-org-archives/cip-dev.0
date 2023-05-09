Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E7EC77B7C
	for <webhook@archiver.kernel.org>; Tue,  9 May 2023 07:07:00 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.133])
 by mx.groups.io with SMTP id smtpd.web11.25843.1683616014485537624
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 May 2023 00:06:55 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.133, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 34976p0g027060; Tue, 9 May 2023 16:06:51 +0900
X-Iguazu-Qid: 2wHHWgyRygyCYXhY4M
X-Iguazu-QSIG: v=2; s=0; t=1683616011; q=2wHHWgyRygyCYXhY4M; m=t3XaCf+H4QxDgAqmDdgoXE9IjEg47JSod3ui25lQNkw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1112) id 34976oeB029455
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 9 May 2023 16:06:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWV6hlBdw7MX1VAxWEUqZDd/oOS+nnoEEnH8vetJaW4MSYMqlN165+LKr+U39ucPhK3P1rzsNVnwmC47a9rpskyTQ29ljQPPmYc8ipVUPdSYZZFttpCBWS7f9L9pYiSPfxPLc4UTTefjNZmkqu/hHXN4wjCNevgOhjYn8Pwk1uuwmfpZ+M75zRqSnbSRfELl/4LBxvKr+2UGaF+PVaELbP7c3z3ghH1laKo7cAQPhJQOSX/4+HtW/Z1ahSaYFZNYk5926YE0o2p4Ij/Pg+3BWlwESiWoQ3DgqEXxmiZug679SBO4rboaLqQ32ySPFFjuOcZTkHFIOtSTIHIK3hFjDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9bAoYbWfp6B5fdgwfkbr3/cjXT9pdg1XCLT8NVJ9H8=;
 b=GLW9oBl42+wtz2zCUDzfevIuo2E+raBSH3yWmVGh/PMYXtZ/kmozTHHF7TvqOqAROG4Z6ORB7A3tsr7rLMqISc6FS3fu3Qfp7grWiNpZLQzJ2I3vWfEV/IvfHpz+9zBYte8mLXLjxq8W2U5KepxZD9qX5MbaIVwIma++Qvcsg//nPyc4Jley2xHyOB9BWc4nJgjEbOufl2YgX7tVmHj7hxPcpdqjj+AyyJzFYQUQpZS6wNRt/Okmqk3JZzap1chKpYsOl8eVpold/46cIYge3WwAgV64pme9o0o8fdDkeP5ePBQrWxF5aoXtgsEVKbsErQ9A+xvCaE+OzkcNOfqVvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <Sai.Sathujoda@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
CC: <Sai.Sathujoda@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>
Subject: RE: [cip-kernel-config] 5.10.y-cip/arm64: qemu: Add nftable configs
Thread-Topic: [cip-kernel-config] 5.10.y-cip/arm64: qemu: Add nftable configs
Thread-Index: AQHZgZNJqJFSfEH3lES9cZ1uvvNNR69RhjIA
Date: Tue, 9 May 2023 07:06:40 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB94200D51D8370EF6D7A8C2F392769@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230508095551.8237-1-Sai.Sathujoda@toshiba-tsip.com>
In-Reply-To: <20230508095551.8237-1-Sai.Sathujoda@toshiba-tsip.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYCPR01MB8310:EE_
x-ms-office365-filtering-correlation-id: 40f1a832-83ee-4d71-ae9b-08db505bf06a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p5ub94KwHhEBEjpjPdtxQ6Kgoyjt/KbQcqPNHfgDBsLyYga0iWWjLn5oOF3y3hO2ZZPvSwGPx8DHiqm0w4Cm+qRQeQF+qcWilgsVseBo6jdt5lDIsnZnbLuYgVRsUUu28Y36RDgRPsWlSAvmCUqjOWLnEehLdtAwJ8sgRVKqF493TVftHNY87cs6WtH3TdyRDzUTcZ/PQmOGxeDBOZfEr8AbUzCkwS4STRXEv0xBMK7NNfNx/MOabDpsAVmfWtvtVMzqmYR8PQuoNUvzGa0AspqXhYwnOjJRo0ZPo5vP22SOL4LdA8SHf91BcyivjKsxnXG6JzZVzQIAvr5J3OU6WTWgIOZR1HjNseQhfXP3PfmV+W4yvf8Gz0gjuVwTYP4026uPMmdk/4dSVj5Hi++/oenT7TjE9gBUcuyXI/qvLevk7Jf6C9iivxQPsp/0+yAOXnnJRism0I/jKk0C7f12iZZ/SrV+hALqkGgEM3XrXg5rNr2ru0AE7uj+0EzohVF78oyNu5Q1RrCVLjIDHzy8TEYm1LmiGvO/f7SsinbGQsVhQb9kEmJ7D+T6k/jrgKeQsF3B1ZT0CSILFBZ8EK0Jd5SUH2hJkJLHFUleqSC2qhCGYC3Y2e7QLDj3PEm2fp968XNuGo0cqjJtP1IwWoZ0Uw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199021)(71200400001)(54906003)(38070700005)(110136005)(66476007)(66446008)(316002)(64756008)(66556008)(66946007)(478600001)(7696005)(4326008)(86362001)(76116006)(41300700001)(107886003)(186003)(26005)(55016003)(122000001)(38100700002)(52536014)(8936002)(2906002)(8676002)(5660300002)(33656002)(6506007)(83380400001)(53546011)(9686003)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?UU55Z2YvNlplMGRnMy9WQktyN3lMSmN6clR0dXA3Z1pFUHg2QXVyOHFM?=
 =?iso-2022-jp?B?OTJ5akZzUmdpWU8raGYzRU9MQTdaSUtjZU9pazd4ZlJnOXRrMHFJTTlk?=
 =?iso-2022-jp?B?Nm40amZFOTcxMUxzN0RwWVdxT3VFUzNqa296L2x5TjhSdTAxYkVrRzBQ?=
 =?iso-2022-jp?B?Titkdk5FdUJwTCtlbjdFN0NFU2xXRnpMTUpBdTd5MGdEWmluTUtIVUZx?=
 =?iso-2022-jp?B?MW9HSmI5SlZCbXZ6ejRsREdJMjdLeFZyQVU1M2d6QVlZYXNNR3prOWlt?=
 =?iso-2022-jp?B?L244UFkra0NZZ0RsT01qSnJaRWdFblVOSmx0SGg4TmM1OW95UitnaS9p?=
 =?iso-2022-jp?B?VVpzQ3hCbElibkxGOHB2U04zamZPbE1NeENocXVSM2Fkd0ozaXNvYWdq?=
 =?iso-2022-jp?B?cWc3UCtSQm1tbncxZm5BYnQvQ2JOd2xwcDY3ZTlOWDEzQk84TXdLanVR?=
 =?iso-2022-jp?B?NVJwRUZkUnpVTmVjTmhVQ2ZDOU5sdmZ0bDlUTlczbEtpMVdLOHBTdkF2?=
 =?iso-2022-jp?B?dmJFWEFTelFPZDEyMFArMUh3YWJqckkrTC9IRkU5Sjh5emdyN29aZjJ6?=
 =?iso-2022-jp?B?TmxrU3owZFJRMUpsUTMzWk1yWW9WcFdoN0hUTEdxdEUraHRBOER5NDZs?=
 =?iso-2022-jp?B?ODIzVWF4UXNKQ2htVjM5czBHRjVxRnJlL2c4bE5UaFdGOGtyaHdraGZB?=
 =?iso-2022-jp?B?ZjV0Yks3cVdzaUhEenNRcVpER3hJSm1mRkQ5TXMySkttRWtLYWNSZEc2?=
 =?iso-2022-jp?B?MTAzS25yNFRSTmxQZVlJUEpzcmlWOEJlZlhQUzRENEZQNUM5a2Q0YnJS?=
 =?iso-2022-jp?B?elk2dUtjUVhSbUMwWDZON3pLVWYzNGl4a1VoRDA4L09ZQ1MzUURTV0wz?=
 =?iso-2022-jp?B?VGVvbFZmdi94c2lRcmRWdTRZOUxNOWxCNkhPTS9wTFprTk9wNTlvRnR1?=
 =?iso-2022-jp?B?NFNYelJYLy9Xb3NyYVZBTTI0NXFqRVhHWktSQW1ZZTh1c3A4SWp1d1A4?=
 =?iso-2022-jp?B?eHhpdEZiUHJwR095eUdWRlBZT2c2YU1zK2txVTc1V25jWWpyeFJBVzFo?=
 =?iso-2022-jp?B?Y2ZncFF5aWpHMEdJVjljUzh3N09NVllCTFR0UGU1Nkh1YlAxYUF5cjEx?=
 =?iso-2022-jp?B?dnNQRkNvTGduSmtqeTlaTmIzZkprRTdYUW1qbVBFTlpUWnhlK0MxY1NX?=
 =?iso-2022-jp?B?aFRtbmQrTUhEZjFidXZmRTJONHMzQWpOQmFRcDl5UEZkaGZvUUg5M1RQ?=
 =?iso-2022-jp?B?ams3Q2xQRjk2U3oyQmp0SWUvZmQyS0djZnVmNVFzNU8yN2JMUW4zejFn?=
 =?iso-2022-jp?B?N0VXSms3c2tIZ01URm9nQ3NaRWVZaHZWSFBHajZDTTdlNzNaOS9BY2M1?=
 =?iso-2022-jp?B?bHdZTm82MFBwYVg0aTRuVzQrVml6Y1VGSm5KU29VRndLZlMyTHkxSXVJ?=
 =?iso-2022-jp?B?WUJFdFAwQjAvbXV2SExDd1QyMHJlc016c2tacmQvS2lWNEtmV0YvYUlK?=
 =?iso-2022-jp?B?ZkN1cjFYZy80VzZieVQ4YWJMWmZKUmtBaTRYV2ZYWklzYjNzZTRXTVEv?=
 =?iso-2022-jp?B?RUJUM1ZZd1FvSTNoWnJnZ0tJUk50bEMyMHJsME43T0pNWW10Z2ZvUGZZ?=
 =?iso-2022-jp?B?SmpBSVU0bmk3ejZ2bWVsV3lNN21KQm0vZmtqb3huVXBlcXdmUHlESWhL?=
 =?iso-2022-jp?B?RWVCM0tBYnhmZWJaZjNKb1o1cVVPV3RXSXNTRnRuOUNOT1FhV0hZckdn?=
 =?iso-2022-jp?B?LzVuYjRsVVNzSExmRkVjb2Q5eTI3TTdkSTcrU3FMMHBXZnRLR1RoL0JP?=
 =?iso-2022-jp?B?M2g3azdKRk05UnllMVFwZWJjSXMzTWVUd3pjQzEzWlIybVVUMFNnQ0xU?=
 =?iso-2022-jp?B?UUlqWmtmZ3JhdWpmR1ZaWlptTXNXeEQrRnFTNThsWDdrOVhKMVpDaXBR?=
 =?iso-2022-jp?B?VlIyejRMeGtVczQyTWVmengrR3VkWWdSeS9MZHA1REJ0Ymk1QWNJT3JI?=
 =?iso-2022-jp?B?ejVLRW0wenhyMldyK0NMM0dENG9CT0xDMHRHTXRjK0MyZ3NIZ1BLNDNl?=
 =?iso-2022-jp?B?bVNtTkg0WklKN2h6MVlpKzVlc3NseVBUL25xU21DemRZSDBLTDZKK3Vo?=
 =?iso-2022-jp?B?b3NrN1ZpRitXamxZdWVicFZESkVQVVI5TTdJYVhHc1FBRGt6a25QMThz?=
 =?iso-2022-jp?B?WkUrc2lWQTN4c09pSVZVL0xES05jMHFYMHlvNk5McTNCanB0cG1tMzFJ?=
 =?iso-2022-jp?B?RmQzaW1qVHc3R0JUSXhIZWJGT0tjeXZldDhWclFNcURkNDRYRzdDaDMw?=
 =?iso-2022-jp?B?anRJM3NMbFI1V0VQNjZJMmVjSXIxWFBpYXc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f1a832-83ee-4d71-ae9b-08db505bf06a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 07:06:40.8737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tGLyEEO+toh4IB+z1wcPnS52FJaUUJPeADLTCRqn00ia9u/4BwUzGEU9iQ0cN6uNEVGwHuxVX59sQphQin1Obz9DZ+dZMNqt6/t4W/X//yIGmQl5Wxz7pkc7ajO2GOz0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8310
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 May 2023 07:07:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11422

Hi,

Thanks for your patch.

> -----Original Message-----
> From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>
> Sent: Monday, May 8, 2023 6:56 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>; din=
esh
> kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip.co=
m>
> Subject: [cip-kernel-config] 5.10.y-cip/arm64: qemu: Add nftable configs
>=20
> From: Sai <Sai.Sathujoda@toshiba-tsip.com>
>=20
> These kernel configs are required for nftables package to work which is u=
sed
> for IEC-62443-4-2 evaluation
>=20
> Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>

Applied to master, Thanks.

Best regards,
  Nobuhiro


> ---
>  5.10.y-cip/arm64/qemu_arm64_defconfig | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/5.10.y-cip/arm64/qemu_arm64_defconfig
> b/5.10.y-cip/arm64/qemu_arm64_defconfig
> index f7ac60f..529baa8 100644
> --- a/5.10.y-cip/arm64/qemu_arm64_defconfig
> +++ b/5.10.y-cip/arm64/qemu_arm64_defconfig
> @@ -70,6 +70,17 @@ CONFIG_NETFILTER_XT_TARGET_CHECKSUM=3Dm
>  CONFIG_NETFILTER_XT_TARGET_LOG=3Dm
>  CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=3Dm
>  CONFIG_NETFILTER_XT_MATCH_CONNTRACK=3Dm
> +CONFIG_NETFILTER_NETLINK=3Dm
> +CONFIG_NF_LOG_COMMON=3Dm
> +CONFIG_NF_NAT=3Dm
> +CONFIG_NF_TABLES=3Dm
> +CONFIG_NF_TABLES_INET=3Dy
> +CONFIG_NF_TABLES_NETDEV=3Dy
> +CONFIG_NFT_CT=3Dm
> +CONFIG_NFT_COUNTER=3Dm
> +CONFIG_NFT_LOG=3Dm
> +CONFIG_NFT_LIMIT=3Dm
> +CONFIG_NFT_NAT=3Dm
>  CONFIG_IP_NF_IPTABLES=3Dm
>  CONFIG_IP_NF_FILTER=3Dm
>  CONFIG_IP_NF_TARGET_REJECT=3Dm
> --
> 2.20.1



