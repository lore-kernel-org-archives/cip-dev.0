Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D015EC32771
	for <webhook@archiver.kernel.org>; Mon, 26 Sep 2022 08:10:05 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.25980.1664179794593865422
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Sep 2022 01:09:55 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 28Q89RYM025457;
 Mon, 26 Sep 2022 17:09:27 +0900
X-Iguazu-Qid: 2wGrHJPOc8MwkGX0Df
X-Iguazu-QSIG: v=2; s=0; t=1664179766; q=2wGrHJPOc8MwkGX0Df;
 m=6npKUb0M/hbWxW2wmcF2h6UwhhIRYnmvNkXrXA7CVI4=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1113) id 28Q89NSF015107
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 26 Sep 2022 17:09:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyoeVSUTOjrOKSuAGblrIuFXRZEozVdZpooWRqPXD1GdWZzOmryWYMJUQCHj8zOmVL92fbJ714c40kqKWM8Er4StIxyi8c+FTY3QlXdd5vOQWiW6vl3jK6krjBG+ZqB5NtIrSdj33/i/DwpNDL58iiQ2FRME9dz0C36YaH3k7nf2xpSXnkX82YhE1iwbP7uv8ur4CLFgPenHi7sfjqxmu3JJ0EejmpEepa5/XSg0FBI5UJjxdJxlKIp7voP1HjkFKHzNr6OzbJVP0e9K610NmDCbgPjP/rdC5v8IvtrvThsis5B5z4jCGqgCO509IqM6yaZvbs69v1+lOiK1P1xYKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38MmCVfM9tO3Yvyd07dW58ktonwg0Qw1TAA4RCSH+o4=;
 b=CVHR+7SrKyegQ03MTyXSzo5wFMCOXhIFBFk0ixJoISgdsY/H1DCGPqrPF01w6iQSFgOXkcR3BBdPYhbwDQH7vx3x7EAhNmRtxH+LShkL0BFihC7iC8zcex37u22xOD6Hxn0rSBnaS5XAqzIkKsECpKz50YTM9ApxtwEwnFWO5Dx6jSf9sBxpfgRvSaM63wS+Opi4dc54sbqzoC91fOLJ0Q0bl0yZ8sGxBNyAGbEKcUdtSoXyCHnlxApcdKh974Ch9BTyy350+g/FCj5/hngWdgg/PTs9zECjtgcSVaKd1k0M1ykbNI3+4qqjtw/ECRf9ZBg13BVkteLQDGIHE8O6eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <uli@fpond.eu>, <Chris.Paterson2@renesas.com>,
        <masami.ichikawa@cybertrust.co.jp>, <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Release v4.19.259-cip82 and v5.10.145-cip17
Thread-Topic: [ANNOUNCE] Release v4.19.259-cip82 and v5.10.145-cip17
Thread-Index: AdjRfr2slsf0DLfKQcuq68lnmg3IAg==
Date: Mon, 26 Sep 2022 08:09:19 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420C94EE9CFD1EF537FA50B92529@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYWPR01MB10392:EE_
x-ms-office365-filtering-correlation-id: c2dccabb-44f0-41bf-8c57-08da9f9669a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 FoVCFZsAkcGB6qgCjTJVrQFvOlv+tiRcdenP1PDLqkKyGe2dEXUYhfWtuQUBH/QkAwzlY+4XGMooMxpWbj8UhKvpVfkPEQdwVgameF9zLq6mmrP0k7aP+gbeFQPnklv/eAzLWsY88AGTV0awJQlPi7Zgyh2580QnKkkzuoHQ5vGr5ZBLj87QyhGGpZSKoJ8bhQlct++8Jloa2JUKNLodl6zhHhoVO65/dKPjBa6sSo5D+3GqnHt8InroVg5+4q7Tb1E3wBvT5OzeOfsceBt3wSSji773pghQx7YbEx19ElPCCy93eoqraxcWmRiR+GFuKg2b8M+BLvezpwNcHN9cN9IUq29Sm/l5nWZMIsF6H11zLWS+V8PiPw2d25SPvwOB4csI6t0e0UuyYi2MaB6QSdy20L11sMCpJxhCwYYqPGOilAMXkJhj3xkZl8hVDNxdw14cb1CEFrl8DK4m/kY+xBGjEp1uDekl6eKU52gcYGpZZwkgwjecb+KP23Rc2D4D+y+epcDdrcE31VgWrtBlYDjGFp5jVUUBJirEKCCEhP8adA84unTIL2UvKD1YUTxtglC6+P2vLTSzYYGyUAwGtChVbC7pdmH0AdczhZUTA6pCCNDzSUUDjnM5hnHtZdKCalRr+lvMNlwID/3bq+Bvupd3jXnEYQ/Mw6f8O15BH/19w8xop8/Gsq/w81xzbDTP/rwECxm3tHv+4nFhSPhv7H7FTJvLSiVmiu8UYFBq7Jl7/9sNToHfvE1sj0X+NLsK6S792x3LzApXUJmNcSR+YtbmQLRySDCYfduzWGWJ6tY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(451199015)(9686003)(5660300002)(26005)(52536014)(6506007)(8936002)(7696005)(38100700002)(122000001)(33656002)(83380400001)(41300700001)(38070700005)(186003)(2906002)(55016003)(54906003)(64756008)(66446008)(66556008)(66946007)(66476007)(8676002)(4326008)(6916009)(86362001)(76116006)(316002)(966005)(478600001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?clJtSEpNdFFCZVZ1ZFNZWkJGVVZkeGQxNFhkZm91TWNQcHNXeW9SdVVu?=
 =?iso-2022-jp?B?TzI0TUl2N2ZCQ21XOVJ1ZWNLVVQzaUtpbVhFWWdteDZkRFBMOUExOGFn?=
 =?iso-2022-jp?B?Y0FDcU9SNmVacjUxODNOSkx0d0ZzNFBwVUpmNlVGMkVBS3ZSUkIyUTRG?=
 =?iso-2022-jp?B?aXhpTTlvMlppSXNXbVZPR2tDZEt2N1ovYnZ3NFhmZXlFSytCc3lXeTRW?=
 =?iso-2022-jp?B?K0Ztd21OcU5rTGdCRzA5a3MrWk5JMEp6ZjFnWmFKaHphbEVoRlFYMlFw?=
 =?iso-2022-jp?B?T0lnYnVZRUVzeWVxZ2RFV1hoT2JHMDg1RHdrM3VsOElXK2VqRjc4T2Z1?=
 =?iso-2022-jp?B?Ly8vUEU5WitETkEzc2kyNElIaGp1Wm9JeWtnYlpqb1lSdi9CaEJ3amxr?=
 =?iso-2022-jp?B?Z2NXTFJydWVjdGxJNG1xMzRiL3FlN0xKeGJ3ZVhEbW9DV2szYlZmWkk3?=
 =?iso-2022-jp?B?VTFvdEZzdmZVcEdraksyQndLWVdydmgvNFV4VC9na3ZsWkE5WW1BOTho?=
 =?iso-2022-jp?B?RTA3RFNYMzVKQ0wxZ3JPOTJuZjltSFJqa3RXclpkbDhsMXVFN3ZGcm82?=
 =?iso-2022-jp?B?bEpxKzk1QUM2b1lpU1pRRG4yV2ZNSWNQWHRvVnQyWmltSW5rbHVQZEVB?=
 =?iso-2022-jp?B?WlBSNXQ4TjZDVVM4dEw4M0c1MjZvUTdHcUk0dWp6TFIrUXhwbU5MUHhO?=
 =?iso-2022-jp?B?UEdDYUc2ME5zNHowL3ozcjNQR0tzWjBnSThtdmlQSUE2TU0rTDc3MDNY?=
 =?iso-2022-jp?B?MXhMeGdRRFhHNmRrRjJ2ekM5anZTZHhGOHIvbjA4NW9HTXZaQm40RGtp?=
 =?iso-2022-jp?B?ODlDNFJ2bDJkdkNzT055Tzd2RVl3QU5lMWg0ZHU4eGtWUUVnOHA5SkdS?=
 =?iso-2022-jp?B?dU1QY2gzM0lNbzBJd2FFcXowTXRadkpRTkpFS2xLbDRNSEZzeWJOSVV1?=
 =?iso-2022-jp?B?T0NlOUVqVlNTV3ZlOVV4YjhYZk9tZmp3dnl3aXc1cG5RNlJGS2x3V1lu?=
 =?iso-2022-jp?B?MXpoMEhIZ0huUHdIWDVSNHU4VWtqSURXcnBiQ3FEaHRKK0ZwOXU4bzV0?=
 =?iso-2022-jp?B?czZxbnhSWGh6SjBHZTE3Ky8yd0U5T1F0ampNa1VRR0FtVFBOZkZ0cExp?=
 =?iso-2022-jp?B?THlBRnZFUVJSc3JadTFLR3Z6OTh0dEMyMkh3dDJZdTJvSFRwR2hGaVB5?=
 =?iso-2022-jp?B?UENJZG1DT1l2ZnExdmZQK0VWZC8zNDVNQk8yL3k5Sm1td0tVblFOSmdX?=
 =?iso-2022-jp?B?RkJpaUl2bjhvTDZuMzBKTVJXSEVmTW0rSURKdU0vTHNab2NSWWdjK2Js?=
 =?iso-2022-jp?B?ZW81M0hDSVMvVFVuUmRhRklmYTBZQVNvNVVJcVBWRGZwMXVmL2dqQmho?=
 =?iso-2022-jp?B?VVFtLzJoVVp4ckR5bGsyaERzMHprZUxJNlZRMkgyakY0ang2TEZNSEpL?=
 =?iso-2022-jp?B?VmZaNnMzS2VncjN4ZFVhY0xFR3FQcVl3Vlp3RTNHbE5BN3krZFpENDQx?=
 =?iso-2022-jp?B?WXU0djlqUTlTZEdqUmc2QnlzbmhIbkxwdVlycnI3endJZk9XdWtvWEZn?=
 =?iso-2022-jp?B?S3dKbUxaWXUrN0VSMEQ5TjFocEUzcEdjRU02ei9xdFhYTHV3YUpXTlF3?=
 =?iso-2022-jp?B?OVJhUlNqR05Rd2s2WnhMZUFnbUhxTjd0NTVuV1MxRmZUdTZFNGVjdWVP?=
 =?iso-2022-jp?B?dTh6NVJ2WFkwR2hERnhxZE9ONlRlam5DYkxEYTZhdzdFeldEMHQ1bEFV?=
 =?iso-2022-jp?B?RVR6My9nOWxVTDhKdVpVOGFpVEFldWhkTmRaTnRYTFZmakI2bjViV1Jl?=
 =?iso-2022-jp?B?UkpCQ0NQMm1NUDQ5WWxNd1BnbHlaMFpIZklodE9GdnhFaEEyR1Y3TmZE?=
 =?iso-2022-jp?B?d3JDdjdtZkpSVzh5QWhHeFFXMWhscUJEYXczZld6V0JvZmJwTEFBMnVI?=
 =?iso-2022-jp?B?UTUzYTdlMGlsb3E3blA3UXJ3cC9tZU82R0N4amtKdWMxWGw5c3F0ZTNj?=
 =?iso-2022-jp?B?N1pHRnYrWWRrSFY3c0dLMTg3WGtqTmlNUzJGbmFCL1lyL1d3VW1MNHQ2?=
 =?iso-2022-jp?B?QmxWMlYxem1tdE81a3ZCbmlha2ZFS0ZtbU9EdStZM0Z5SWxPTkkvUnNU?=
 =?iso-2022-jp?B?TXZMemF0VDEzMkVJcTY4dzZBYnJtbTFqc25aeDViZVI3SEEyVWcwVStx?=
 =?iso-2022-jp?B?R1RoM3E4R0prZWpyRUJWSnRSWDdXbkc0YXkvZHJNTlpURDFQMXJkRkJV?=
 =?iso-2022-jp?B?c0h3VWJJTE5DNVdEOXgydkQvdlFqZ2NLQ21OQXN2eHZ4TEYrTXAvcGNn?=
 =?iso-2022-jp?B?VW9xU25nbHM3a1dIaDRDeHZMcWtNTUduaEE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c2dccabb-44f0-41bf-8c57-08da9f9669a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 08:09:19.2220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 8J7k3iOw1tWyOgGzj7rRgxr8uNrCh3/PVpVczHWr6R3yLaEZTtEgs0DeZ+S8pox515zyCXYBRX9rYUesPTLGgdLxiFptPi471A0xzCjqnIhxlAV/KRudeemn8ykti/ZF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10392
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 26 Sep 2022 08:10:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9544

Hi all,

CIP kernel team has released Linux kernel v4.19.259-cip82 v5.10.145-cip17.
The linux-4.19.y-cip tree has been updated base version from v4.19.257 to
v4.19.259, and the linux-5.10.y-cip tree has been updated base version from
v5.10.140 to v5.10.145.

You can get this release via the git tree at:

  v4.19.259-cip82:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      91f283faebd1a92efc2cfe0a3de7c568c87e5ee5
    Fixed CVEs:
      - CVE-2022-2663  netfilter: nf_conntrack_irc: Fix forged IP logic
      - CVE-2022-40307 efi: capsule-loader: Fix use-after-free in efi_capsu=
le_write
    added commits:
      CIP: Bump version suffix to -cip82 after merge from stable

  v5.10.145-cip17:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      93a53e86925ce8c2e0608e173e2c7b952ee61cdd
    Fixed CVEs:
      - CVE-2022-2663  netfilter: nf_conntrack_irc: Fix forged IP logic
      - CVE-2022-40307 efi: capsule-loader: Fix use-after-free in efi_capsu=
le_write
    added commits:
      CIP: Bump version suffix to -cip17 after merge from stable

Best regards,
   Nobuhiro


