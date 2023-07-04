Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA1BEB64D9
	for <webhook@archiver.kernel.org>; Tue,  4 Jul 2023 04:33:36 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.51698.1688445211274091273
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Jul 2023 21:33:32 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 3644XKDl2180845; Tue, 4 Jul 2023 13:33:21 +0900
X-Iguazu-Qid: 2rWhoCDaN6FyFJ4plb
X-Iguazu-QSIG: v=2; s=0; t=1688445200; q=2rWhoCDaN6FyFJ4plb; m=AsqDayrHHSKZ6tAKH8Z8hXCK7xQFTXwHdbFzI0UUuE8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 3644XIIq2663498
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 4 Jul 2023 13:33:19 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nf8rIP+Gw5JVRqg7760Ww7UINjQoJskqSBlaCOK2LZ7ElGmLk3PnCJIQGDHWiOb3UDjTt3iKZzXzPAAL/7cyT7WpOqSrvFB/u59TR6NRY9GvmdSKov3N4eIhCuuIAr4rcnbsTACPJjwg/HsnZFshO/bdiql1UwquajKTSTecbhReYS2uffCOs/w+5bUqwrv6JtyrxqMTijLUzwNBslhQk0+pn5jh0R3eubcn9uesPy2FuXgb2Vjf9PyiLsMPOFjsuhHP8MQQ5NVnPdfh3RTxQPY9njqc4HOaBZmPOkiLcRPO9RgA9byctKh06NqFWps29GtWMf+Fe608YVNv/2vKqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unMUZk+Y8I/vXq2jHP4Qs+yxsSxPq3C4WFSp8b3zukA=;
 b=kT90Z5yHvT40bjhO5MrM6AR6O6LxDAa20P9kPBC+YAeTtta8nvHMqeTsCuvLLuJQy5GOZsda1er4IyGw3Bs5QfmrdN+Tx/t235lXHcUrE1YmCurgW3iIxHJdiw0TncPCAWJLlriF8D5lA3c6KWEnVJ1WYcOzXkWLlnh8vB3e2YTNw5vncAywoAN4i03qqGdYHQMH21K4zgcDoNsbH17yvZj/gPc8uM56l/PCjYGPPZViG3zg/CznLIpf5WCf9FFMOi6kuZQBkdm5TfPuzR7hp7+oJzfew0jEpaAtuOIdJ8CF2fky3HSZqDy+OaPzSepGgTvg/LEXadhPvh+qEaxBoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH 5.10.y-cip 0/3] RZ/V2M I2C driver improvements
Thread-Topic: [PATCH 5.10.y-cip 0/3] RZ/V2M I2C driver improvements
Thread-Index: AQHZq2q9UwD+8KMI30qy9o9rfAeN0K+pBnUQ
Date: Tue, 4 Jul 2023 04:32:59 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420A3CB3F831F9DB6FE51CD922EA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230630155118.584293-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230630155118.584293-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYCPR01MB10294:EE_
x-ms-office365-filtering-correlation-id: 42c81c29-6b30-42a4-d244-08db7c47bf3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Y3zOy+c8jPg+LVf5iD8dllpIUdG9mKmx+41frl3kQL5KFWMbRJMIMfqj9UNw6seFebb39d6wfsCGm07TTXYNDt+pe6Mr4Z+OavLcno+3pzGoJ6H4atezHXE5RKvdZdrZK071oKTIigMqRAHkNmkKwWjOcKLBVtwwDGLoYDIzhniaJd2dRDXDe14yAzCO5ofdCJbqyMeyKjy5DRLYM0yTcSNIeJNHjLdbHrOV2oizM/JmBM8qzqeSHszZBHFp6LJzDFnpqd+EBNPsJI5Zg7BhVpwlCSf40ZadjyYK8nC+CvkT+ZigsX75zKkYlagVwIVBFimAnDpL5qYSgV/dDak+92XquU36e7lGBivNf6ar9xvR1c8cu4l4HXUNRKh2V6d17clnJflP/xH5TGLKW2CJlUrPGk6/TjFJjfxqGWbChDHUS4kAE1NexDjSIv+aYW4hDOY6mDoMVlN50CdA2HSQuok5iKKGdH4huFnULC3fpKN1baH5kF3LWZRI9CVTAvJaRTZ+gJ5IseFsxin/HEW/MUuUusKDwNdYNilhH28no4GcNempoW8ROGdqjbLN8rmA/3hFjbltGo/SnaT/0aYX4MOsspgte9D1qubEU/I268fzTATXJAGhjy/rrm2FKbkY4jNZYC+QnPyI6r9zNZMqsJCf164oGohHVfTx34U4GyZq9SXHZU4Vhb87C5KiWHXL
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(451199021)(53546011)(6506007)(316002)(64756008)(66446008)(38070700005)(76116006)(55016003)(4326008)(66476007)(122000001)(66556008)(66946007)(38100700002)(83380400001)(186003)(26005)(9686003)(478600001)(8936002)(110136005)(8676002)(2906002)(966005)(71200400001)(5660300002)(7696005)(41300700001)(86362001)(52536014)(33656002)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?V3RrQ0NRTlhkOTVYbUd5cTlUbXd0UzlNQlo1U2xtQXFUYW9jbHZsZ2Nu?=
 =?iso-2022-jp?B?UkU5WnRuOXRxQXhiS1JZODJMNHVnRE5TcS92T1BtVytQMHVlYWhoejNa?=
 =?iso-2022-jp?B?RnFUVTBRU3p4Ry9KMytSOCtxTTZDRXpPbmZiNlhwcjJaNklGWnJwcmJn?=
 =?iso-2022-jp?B?T293dzdRUW5IVlY3ZGE3QUUzY0pFYnQ3ZVBBaDFEM0hiMEUyblFIWlQz?=
 =?iso-2022-jp?B?UVVoQStMNDBaYW4zeHJrOW5ZL3NBWGVQNytXNlA3QkdYZDJuUUhxN1Bj?=
 =?iso-2022-jp?B?NU1yMmE4d1ZYblFyWHZzT2pUQ0VyMk5aVjdoTzdaZ0VBdU1zNDhhOW5y?=
 =?iso-2022-jp?B?RU45K3ZYNWtOdmE0LzdsZjFjUURQaXN0NGhYS0hreGhJcGdkU3ZNZ3lp?=
 =?iso-2022-jp?B?aDZwN0k4Tmd6dTdKNkljdjg1VUl4NVNOU09DUnVrQkU1bk1KTXo2clI2?=
 =?iso-2022-jp?B?bEtFTHhHZHhHVjBFNHg5QmFNd3QvVHhCRXRyRHNjVWxGOHVnSStmczhO?=
 =?iso-2022-jp?B?MDVManJyVWo5b21QNnlUblc0Z2JDUENhVHpLV2N4NkMwOFM3YS8vdEVC?=
 =?iso-2022-jp?B?QUR2b0FmRXNLRVpJb29GMVBCM01TVUVHRHF0T1NsVU8rOVI2RkxGTm5s?=
 =?iso-2022-jp?B?YnFkTTE4YTViUUxjTGllYWNjeG81SWFCMkpYaFVkcytTa0Vwd0tLVlVv?=
 =?iso-2022-jp?B?U2JPNEM4endqQlhMTUZoY1ZYMFZUMEU0QUxtNVdnc3EwNExjcnByMy9V?=
 =?iso-2022-jp?B?M2JDOE5DUDh5dnBWZ3NwR1Y0MVp3TWI4S3h0NlZjSzBNaWtnSTRJbnA5?=
 =?iso-2022-jp?B?KzJHbW9QWWZqNWdBZG95NHZMMHlMQlpzMk5kRCtnSEtnaVdQUUFrMTd3?=
 =?iso-2022-jp?B?b3BHMDRIT040L0pycTcvNDJtaHZnaDJuVTRGUWVEa093L29WZkVmbDFM?=
 =?iso-2022-jp?B?cnVWZTNRV2o2OHBPb1h6NlJ3MURTWDl4ZkNQM2ZYbk12VnYrbHI4c1JO?=
 =?iso-2022-jp?B?cVhaM0pKdXUvV1pRQ1RWS0poTzBsZ2VmYmhsbmV0ZkVMVG1qekZLZ2pu?=
 =?iso-2022-jp?B?VWJiUVZvN3gvZ3RjTFYwMi9mRWFrUE1OcEtOS0M2UHhicEFCWC92Zllm?=
 =?iso-2022-jp?B?TDc3MlJpZUtqdUlBSkY1SnV4N2N5cUtEekFFYWxNd0NmVXNFNEhtcEtV?=
 =?iso-2022-jp?B?akxPQlViMmhvYUUzcG1MRG0rR2UrOUlHSFdTcFFkdEcrcTlnYkV4VndO?=
 =?iso-2022-jp?B?L2VPM1JZeWU3TTJSMnNzYm1sd1duYjFzZmlFcFk5ODVtMC9IMDhZTkM3?=
 =?iso-2022-jp?B?cXUyQjdJR3N0RUdmR2orTlBpdGJmQ2tHb2pUVmxJQlFSUTg5WVJrZnpr?=
 =?iso-2022-jp?B?d0ZqQ2xkUXFOaGd6VFVCL2pmNiszdUVzZ0dSUDQzT29QY295WnpMT2dD?=
 =?iso-2022-jp?B?WFlJalRkQkR5K2orU0tEQ3lsRjRJYXpsME1VdnZ0NWtkUDJ2Q1VSNVRZ?=
 =?iso-2022-jp?B?cmo3LzdGS2xCOTJ4aWh4VTZiUFk0Zms4aTVWOElDb0tqUEc4T0dmaTd2?=
 =?iso-2022-jp?B?amdyVHhoSmx0QWZxY1NtUDltcE43SUFTOFY5WWhDT1ptSmdoRFR3aTJm?=
 =?iso-2022-jp?B?ZitBNlJsNkJqSm9IZ3VpY2xQdlVwY3BybDdwdzgvcTdoU3Q2WXh4N2lt?=
 =?iso-2022-jp?B?aStMTHZ5UnpBd3hZWFpXRXphTkp2RSt4NDZ6akpvZ2FxSVgxdWxRd2lh?=
 =?iso-2022-jp?B?NnJZdE9EanRmQ1RzOXErTUNReXdKcnQyc1YweXVKaGdjZmhmVDRpMlhO?=
 =?iso-2022-jp?B?U0NFVFY5V3FTQ1FBNGcvUjJqZlM0YUlGZ1RVRUZnR0ljek5qdVZvbWJF?=
 =?iso-2022-jp?B?OWdxNFBnbFdNbWlzTWpzS2V0RHliNkhySy9LRXpuQWc5RnBJbzF2cDZK?=
 =?iso-2022-jp?B?K2dwVXhRdlRSSWxIY1puaHJiaGVJOTdVS3NCNVU3MlFsVStSQnBrOExU?=
 =?iso-2022-jp?B?UXFGYkFGUXFWNHp4VVZuT0RDY1hxQUoyWVRGOVgzRHpsL0NFOGx5MHlr?=
 =?iso-2022-jp?B?SVovUmRPZnZGTi9YbEhiNTVzQkNrdFFoaGhlSjRkR0k3TzBzUk5UTUNH?=
 =?iso-2022-jp?B?WUNtUE0xK2w3UlltK3Y2akpGdk0zNmdQVXZWUUZZSEtKUWltQVFlZnBa?=
 =?iso-2022-jp?B?K1lZOWlvWlRJZno5cGk0U1MzeSttZXlSdXBHWWRTejlOOE12ZVEwNS9W?=
 =?iso-2022-jp?B?VU1XeC9pUGVkM2I1dFZiOUVHV3N3ZTlqb3RzbGlpR1pnUGJTVlRqVWFE?=
 =?iso-2022-jp?B?THNjVUdXUjFtN0tyaDN5TTl0dXJ2SmJwMkE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	c38W7BftyMk05NT0XHC/vxpMbzRHHeHlM92thTgDk4cwIqSbJQH/JHNcuyW0l4Q8eFqjltWs2oPcDCg0lLOZbJP26UrtjP3XlRGNxZU1wHg3v2xByvnmo3YrllxL/d3oBz4T/hIRWm0nVHTSa6lhqmj3Ghz+hBEuJNbmk8MyoOkCc5Pg6dTY+ngbYW3Q9w37aSEHvDV379z5ngOmgE0TDBBq5W9wGkEhAr3TqnIJUFiNSNgppAMFghtGB5rTNPU3KX4PJd1fdXa1+z4Y9E0D5l0BaQjxRkzJUeEULs5+fGg8gBMCF6p5aHaCQMdDaFZmyMBzWNI24J/O+El1Wgym3nn7QnKfsuvn1cn/PtyifcWDFKAKk2fX/KDIcPlFnDQEWVt1ZjGM5dUXGgLHnO9/PtTBiwqjMwJEiTZ6Yi5gBY+A+KlDBrUQHp4nbG50HZeEb2MrZPk7k9+HXAjR6OfZTHAMFprUuNd+aGbFd2BVTAacxaqXtuNkGew/9OlN1uJWYyQtWAILcSOnzkjnFeQuv1Uo4G2cjzuaP7MpyfbuednpxpM56aDGxWXjDtPGEWMlcROWupULscD2rvu7NZG+cNZevjOPwLxUBehA1pKV8Ks2wk0ICArCuSNtefojaLPrBJnnn+YDEooBK+oLB1c+nvXfcSCN7KTbuqXrrkviX11x24+bFP8s88w0j+8iJQjXCOek3BbjFh1ljPonZDJ5ZgptgLZPTMOOGj5d2dP97VYNCHM4o65RTRn0VF7ez/kk+NnFJbTBU6SOhB2zh28IoR16YBzIlPoPyiwH1jKfux6F98ZNYG1HmYzfASVDjhMMOTO3ATQOitn7TjmC+gWlsg4VI5wDAx5FY71u48KucJqe/oUvZzHGmdsJEYeeQ6WJ0i9PWDBqnwYNRTK7nQUxfg==
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c81c29-6b30-42a4-d244-08db7c47bf3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 04:32:59.5960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vWaowx7+T9uDZUA40ae/Dzzj7UXHmkBEJrZkPqKplSwn7HNbTWM1XJ1n9Z4lAl9wqSC0b5LjCp0LBI/1+OtM6MshGTd64x5GwZwHeUPareqNYGRnSe0f+cuCFTl61Wn7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10294
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Jul 2023 04:33:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12197

Hi Diju,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Saturday, July 1, 2023 12:51 AM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Fabrizio Castro
> <fabrizio.castro.jz@renesas.com>
> Subject: [PATCH 5.10.y-cip 0/3] RZ/V2M I2C driver improvements
>=20
> This patch series aims to improve RZ/V2M I2C driver, based on the feedbac=
k
> from Pavel.
>=20
> All these patches are cherry-picked from the mainline.
>=20
> Biju Das (3):
>   i2c: rzv2m: Drop extra space
>   i2c: rzv2m: Replace lowercase macros with static inline functions
>   i2c: rzv2m: Disable the operation of unit in case of error
>=20
>  drivers/i2c/busses/Kconfig     |  2 +-
>  drivers/i2c/busses/i2c-rzv2m.c | 43
> +++++++++++++++++++++++-----------
>  2 files changed, 30 insertions(+), 15 deletions(-)
>=20
> --
> 2.25.1

I reviewed this series. Looks fine to me.
I can apply, if there are no other comments and issues.

Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/91994=
3145
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


