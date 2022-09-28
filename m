Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9876C07E9D
	for <webhook@archiver.kernel.org>; Wed, 28 Sep 2022 02:20:15 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web08.3352.1664331614015797586
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 Sep 2022 19:20:14 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.153, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 28S2Jp8E009116;
 Wed, 28 Sep 2022 11:19:51 +0900
X-Iguazu-Qid: 34tMX1gd7hgJhNhjFu
X-Iguazu-QSIG: v=2; s=0; t=1664331591; q=34tMX1gd7hgJhNhjFu;
 m=76zYZgT4YYCemo04TKU3jfCJH0eN9HomOHYkJDQOs4Q=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1511) id 28S2Jm6i035431
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 28 Sep 2022 11:19:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DO4XLD/+uA81F+HQttGnuVvViwgM3uJmgmrnjhVzOZBXkWXFJ1r+4hNB1HIz9bGZXbVfphtkbGLbuBlCegOrKZdQdbc12La9v4QNb8JlpHZGIK7tMpYOf1pQYxpIxQIihgttjJtDcNFPmyufq3jQpy2kAdFtqPPdLwJrD1LIvtiDnH8Tqke4v/VQ349SIEL3HqYqfbuBCh6lcQuaNG6dd7EkpxVVeI5Gjhm2DgjwUqYQpfDtQFjkohRSWShEd85RPSFGLyP0eQmF+z+gcST59HI1deiPnX8uqtlUmF2O0U1InTvLq2SWBjVQH5J10aqsJmoDaQ+n1qTa5Gxu1fXEMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkAHI7goSSBfATJpWUd6+GrhD52SRKNi3czimNrmyMM=;
 b=QuN1xZi1v6UbMJ/LNRRkJPFLcZM8wYhMNjL3BCKFn3NN79a3WYRA5zZBiKoYNe1kf+Jcxe4ox0YQd+ifZaY9rxoJp9AhvlXNdkXxeuNJY3psmKGdEiT9/lGwA1+DhiEk8o9wxepW+EBQsq9Od04Nry8yvLqcUN2rSvbrOt8GnqhZTI/3gB0Vm9Rgbp2IZfw1QZdoqlfe/N4epetKI5TuovqZZnoMgGQd2W6eQXaOhhqrTC9lanUsWiAXCu8zgoxltkk1yebnGtdQgh7WQhA9XlI6UJqn1zMkumP/fbC0aMklC7K0cAxp+uDAn0inYac2cmKqgxztDjOA1NI2kymxBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <florian.bezdeka@siemens.com>
CC: <pavel@denx.de>, <masami.ichikawa@cybertrust.co.jp>,
        <jan.kiszka@siemens.com>, <Chris.Paterson2@renesas.com>,
        <uli@fpond.eu>
Subject: RE: [cip-dev] [ANNOUNCE] Release v4.19.259-cip82 and v5.10.145-cip17
Thread-Topic: [cip-dev] [ANNOUNCE] Release v4.19.259-cip82 and v5.10.145-cip17
Thread-Index: AdjRfr2slsf0DLfKQcuq68lnmg3IAgAKdrKAAACo+4AATUn8MA==
Date: Wed, 28 Sep 2022 02:19:46 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420DF3BE19B60B7CCFAA25792549@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: 
 <TYWPR01MB9420C94EE9CFD1EF537FA50B92529@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <1f6e6c23574f42073aba6afe27386c500c44473f.camel@siemens.com>
 <20220926132359.GA21302@duo.ucw.cz>
In-Reply-To: <20220926132359.GA21302@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|OSZPR01MB8896:EE_
x-ms-office365-filtering-correlation-id: dfe0f753-47c6-41e6-24a8-08daa0f7e99f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 aJWmlUFZOCVsq/20floyD0+wIbp2X4Of271h8MvIZGea5xsBx9pV+ynv7kN4an7ilAdKQZ2seUWTg8TjsDMPvL2pjJPxEwNcrqHZXB/GlCzpi2ewWkfSm1okYFCkofL6IfSFpbggrbeWPgeXTTi4SJxL6KmD7ZJptwNcHqnRu+iEin4Wxln0L8sJZmefqXPWtu/4N8HjLBHfW1X4atxxlF7/0UL4e/XFOscbsYphvj+V0OnLVVW4GQkjNZ4ShKFYmg24r9C1gBCMpgWm+FUT0HvsdmmKv1D4S0IpwibOWw6YRvGWu1qoiPYH+HQTLEV1s95aqHocNUdg9bEv9zxoRLMmm/rI2wQfWB6sbBwc6LNW1a0Y6Wf3wBtU8LZTk0wdbx511kVFUDUnVNDPP3E7BKvnwMCsety+0eyc3lz4Wr9vNXPPlwgNuivlIMuQLa7iXjzOPv3RLjQiWCGqSEpQzPo1dsTkzOhnCEE+QEWkh15+yQ4wMoSUV86oqwK+/3Cauw0tBoP7ad+Tgb8hR5Au1FHjaiJ033vV18UkTabOC8iY4XjN9VtrUXmLtnSGjf3cJa/wOpgNQezWXWghq1aC3fiCm/nAxJL9nbXPF+CEZyODrMCMT0mxRc0n7TObRt1Hs8wcD7Fn+hoLw5rBkAhR81vdhELA/6He9XDk33dVy62Deoq6D55YSiXj3qk2/TLmedE6izXpK/rR7G4tu1KVWAmwG4QopCtFv/viPz4BeIfdwYx9iUwDZ+X8EtXoRa4skynksMD32e0vNPVpoxMyMi812YlQNcj7z7KVpFoZLZI=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199015)(38070700005)(316002)(86362001)(33656002)(55016003)(122000001)(8676002)(38100700002)(66946007)(66556008)(76116006)(64756008)(66446008)(66476007)(4326008)(71200400001)(54906003)(110136005)(8936002)(2906002)(5660300002)(41300700001)(52536014)(83380400001)(478600001)(966005)(186003)(9686003)(7696005)(6506007)(26005)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?OWhYZnZVRWhtZDV6dGtiZWwrcFd4SzhRYi8zbVpnOEtUV3NqRXhMczM4?=
 =?iso-2022-jp?B?bFBxT2xWNFUxd3VwK2NGc1ZEV1hXSCtyZzJnVndmNnJKeG41TzdJRFB4?=
 =?iso-2022-jp?B?NXk1SEJiYlFKR21MRlV0TzVPVVh3eEplQXo2ZHVEclY2emY5T1dpOUxj?=
 =?iso-2022-jp?B?U1VDYk5TM21FSzVEL2hsaGRmVjRhVWVWeVlMWjZ5MXFwMjdNN0FwNWVj?=
 =?iso-2022-jp?B?eGpoVTZuMUozUUNwd3E1aTdpdndyZDNZWWFFQWViSDZoMXdveUZpOHBu?=
 =?iso-2022-jp?B?VUQyOTUrUVpCeXNOT0l0Qm15anlEcG5sdjcyU1dLVmtlcSthSTBWYVA4?=
 =?iso-2022-jp?B?RSszS3hlSDJ5TlJ3ODU5azVrNGVHcUpJd1FGQzgxL2YxQjN2dXduY3Rw?=
 =?iso-2022-jp?B?L3NjMVovdVVxdGZ6SUc1bnlhUXZ3eVc2WWYveVBabGhwZEU0NUtQRnp0?=
 =?iso-2022-jp?B?R0NtZVc3ajEyYVZ0UGljdWdqZVZSK1lIT2lmdFdEY0h1cDhtTVVSTzhV?=
 =?iso-2022-jp?B?S3BlTlJrMG5scW5CQjFFVE9KZ1U2SEttbVo5T0wyZmh5TzNmRGd4anFO?=
 =?iso-2022-jp?B?SktISjFzTWdFcjBnNlF5UHBjR1dvSUpPdG5MSnY1cURLMjVzMWtpaThy?=
 =?iso-2022-jp?B?TVdQSGpZQ1FIbEtTY2NqandBSThGbUJ2T2RvcWpHeUMwL0hJYnZTZytx?=
 =?iso-2022-jp?B?WkRTV2FTdjZkcGJiL1FBOGlDMkRVbDIwWFpYaDBiOWV5OTJad2gwZVBE?=
 =?iso-2022-jp?B?QzBtZFkyUi9NSnZjdUJoNUNMYmxQNFdJRW4zczFrcjRmazlmSXRLNzFK?=
 =?iso-2022-jp?B?MGFUbURZSEh1TWFUWlBMNnA1Mlk5SXM0UmJWWmV3a042WXdvano0ajlq?=
 =?iso-2022-jp?B?Ull2N2d0TDY2WTlkMTFGcGtEM01YNkdNbSszWUQyYVI0RExCSmd4MjJP?=
 =?iso-2022-jp?B?TTAreU1rL2ZadWx2Zlk3WU9vQ2RMMFdIbXc0YUVMV2xWL1lwSjhVaU4v?=
 =?iso-2022-jp?B?WTFCNThLWllHSnpzT1YzSXhNTUZESS8xMXZBQXZkNmxKc3JrVVlmY0p2?=
 =?iso-2022-jp?B?dHZzSjRMTW5jMkgwYmpRblBpWFMzZm1aSGZJL3hxaU41bThBMmc5YmR2?=
 =?iso-2022-jp?B?V1djR0RkY2h2OXFuSHcwMVU0MUxtS3RnUUdIMkJiSEZBZFVYZnRzb0du?=
 =?iso-2022-jp?B?QzNSV25KTTUrOXlKdTZyMlJwT2ZtRitXbk9wcFc4bWFlVFFmU2M5MHpW?=
 =?iso-2022-jp?B?UGNsM2FiZm9XbDNaV1ZMM0J1S3dsbmVIc2xOaFR5RXJKbkVuZlNiOEdN?=
 =?iso-2022-jp?B?b0hIZVZLSEhnZ2lWNGNSTzR4VzZwdkZtbWl4ZDZrcXowTWJIWk8wOGt0?=
 =?iso-2022-jp?B?ZEpGZUxqY2swb3pBWHhpaFFvQlRBbWF3dHlHeXN0M2dwbElDVFZPNmFH?=
 =?iso-2022-jp?B?MkdWZ1F4L2NzWklhenpYQWtjVkE3MlF2RHE0ZlhhWjdtM0d5ZzJiWHND?=
 =?iso-2022-jp?B?WTh2QXlRaGsrS1YwRWp1YTQzVk5kVHJpVEYxZ1l1UTExZkVpTHUyTERD?=
 =?iso-2022-jp?B?WTZoazdvYzdrTGhoclFWZjlhWUhaL282eTJzdlhhS0s3MVZyNzVDcDgy?=
 =?iso-2022-jp?B?VTZ1WUI3M0tzc0E3WnBRWmJOakpNTzljVzRBbW9GbEtmR1N0UVZRSnBU?=
 =?iso-2022-jp?B?TWYrZEZpbWJwNmR3V0VTOXNNeVVwRkpBcVZuN3c2ZjhxaFBvbkdkTnl1?=
 =?iso-2022-jp?B?dDN4NElMeVlaTDEyKzlxcnAvWWt3MFdWaHpYWGFiS3hwemhFWkV0NUlW?=
 =?iso-2022-jp?B?VFZpTk1nY0M1NjZJRXo0bnIvd3JDUTZVQXlDT3JTSnA4bDF4alNlNUFJ?=
 =?iso-2022-jp?B?bWRxUnpRdXRtL2N3QUZ1dXphaDk3ZHJUVjNZclRTSnpxcy9RMTBJMjVD?=
 =?iso-2022-jp?B?dmgwSk15RmQ5OXhmdjhvNEtOS2NqODVnNjY4Tk5lcVhtb2lPZkJxRGlW?=
 =?iso-2022-jp?B?cDByVDFyU0ZHZ0Y0UEpSdThPa0Q0SlVveEVsYXBTVlZTL2sxQThoYlR5?=
 =?iso-2022-jp?B?MENzZi8wR1JXY0luQm05b0h3NkQ4NXk2c2tTby83L2ovL3d0clhFb0c4?=
 =?iso-2022-jp?B?ME9KUlkycWNnNFFtcWlQZ281dVlJQzQxWVlWZTFHTUVDbEtIL00yVTVN?=
 =?iso-2022-jp?B?K3NHTmduRU8vWm5IcjZwY0VMdHA5eGpJVlNjcG1Oa1l6bENvWmxvQzdw?=
 =?iso-2022-jp?B?OHhlQVBUQWoydyt1QkY3M3A2ckF6TXhsZTk3UVFxdFJPL0c0TjdFZjVp?=
 =?iso-2022-jp?B?cGR1clFQSUtseU5VNzE5ejU4VTNUQW1tN2c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 dfe0f753-47c6-41e6-24a8-08daa0f7e99f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 02:19:46.2921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 MheqaR/HNEFRvMjorGERJZ4L6h79Uzd2k9qQMs+16OWTMBJAnDRyRCTNt0UDKWpv0MRYsil5utCub3Hm9VHvVlxX6+tpYKN5w4X3OntJVfZnfqiYagqjshB13RsxGkNL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8896
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Sep 2022 02:20:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9563

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek
> Sent: Monday, September 26, 2022 10:24 PM
> To: Bezdeka, Florian <florian.bezdeka@siemens.com>
> Cc: cip-dev@lists.cip-project.org; pavel@denx.de;
> masami.ichikawa@cybertrust.co.jp; jan.kiszka@siemens.com;
> Chris.Paterson2@renesas.com; uli@fpond.eu
> Subject: Re: [cip-dev] [ANNOUNCE] Release v4.19.259-cip82 and
> v5.10.145-cip17
>=20
> Hi!
>=20
> > > CIP kernel team has released Linux kernel v4.19.259-cip82
> v5.10.145-cip17.
> > > The linux-4.19.y-cip tree has been updated base version from
> > > v4.19.257 to v4.19.259, and the linux-5.10.y-cip tree has been
> > > updated base version from
> > > v5.10.140 to v5.10.145.
> > >
> > > You can get this release via the git tree at:
> > >
> > >   v4.19.259-cip82:
> > >     repository:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
> >
> > Nope. The git tree hasn't been updated yet, or is this kind of delay
> > expected (mirroring)?
>=20
> That would be a bit long for a delay, I guess this is a case of missed pu=
sh.
>=20

Right, I forgot to push to repository...
I pushed yesterday afternoon (14:00 JST), so it is updated.

Best regards,
  Nobuhiro.


