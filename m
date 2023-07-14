Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4B6EB64DC
	for <webhook@archiver.kernel.org>; Fri, 14 Jul 2023 09:57:22 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.15146.1689328637893004686
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Jul 2023 02:57:19 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 36E9uqf31735583; Fri, 14 Jul 2023 18:56:52 +0900
X-Iguazu-Qid: 2yAbG2OhpgZKjnC9YH
X-Iguazu-QSIG: v=2; s=0; t=1689328611; q=2yAbG2OhpgZKjnC9YH; m=W5Kwg3mbTJ/Mttuh6pX2DdF/latVqrbGWX8HK9UWqsU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 36E9unqI400080
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 14 Jul 2023 18:56:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmzbmZzrRQRIrcjqTSMZjImCqvQpxhDDdn3WtlMvwgzL9UC9U69dZsmz6nOMiSCXsDeF8fPSRD0zvE6X4XWeJ3doJj9c3hwJYwj84PrQWCkdFCdmsSTjRx4e57qA7tvmRihV1andcFZp1/emH4uqtbDxrsyWUy/ojeXf/fN96adgarJ2s0skaJ+P5N5nvMoRUNHqqmA70MrOW6RF4hzKXwzR441Wo3xS3CjnpN+FGvcRShcEQJMjmaW6kbH1rm2aqZq4shEJ+XL5oXxXSBwTQSy4d8Bw7hf8SuaqjmymCxd8jcF/D+VJWTOf6I/485uQ9Cm16UA9E7wEoOVYY/TlSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bClY8LOAfBZXVdjY4FBbt5IcdF6cX6RukhxwJqOyg4=;
 b=SIaVEVSRQQnhnDa/ujGfUaxhnjdCeMI8Oar4ziaI6eDWo8DzEr1/UFujTEWP0kYRM5rfRrLNYBXXP1AT4JHvzxXetjZeZXUC9Ffe5yd/waFG67lotnbh+7/XjQvA5lSPtlV0tmDsK0cKbkx3Ogs5U81uyl46Z7KdB6IxmuBT4DTK+PdyIG/pN15c+gA04JkGhiSixBR6QeRqNJ3Y3PUfA4/Q3hmxiocl60wQbMGuVgS6lZlwylkF9D2hpKX6lCKPvl3DVWleZDoXAK5LuxeufT2Kk9mZAQNp/0+Lq46nt6RwuII+88+WQHA1bs/rWGeops9gsUYNSpL2NCu43OMKGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>, <Chris.Paterson2@renesas.com>,
        <uli@fpond.eu>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v4.19.288-cip101 and v5.10.186-cip37
 v4.19.288-cip101
Thread-Topic: [ANNOUNCE] Release v4.19.288-cip101 and v5.10.186-cip37
 v4.19.288-cip101
Thread-Index: Adm2ORG+UKh3VP6ASiia1YvI0SzFKw==
Date: Fri, 14 Jul 2023 09:56:47 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94203C2C911BB711804CC0799234A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|OSZPR01MB9424:EE_
x-ms-office365-filtering-correlation-id: d9cd516f-e08d-4527-c557-08db8450a362
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 v7sgXN36rUYAAjnWdduB/IxKGo4AFEqDWceZPrIJA7TiA0oIRR2BE7o7v2KIKbI9Tc8dktQz6oJaeo8ZGrWvs2CZhDoBcGMIHMSiA5DwxwkG82dZCbjqDQ70HMwt1SVg+VJs0JxgSUVEIkDr5pJqCid6fZZVdNBzWOIdngQGGrGaN843NIIK6GhjEAGcse7dOUakIcnUpEelotM7VQUgl0bX94SdzwW0vv1SshBOsa0pIM14QIFdwSDC8ucgOHstBS8DmE3gf02thGsLnlV5mfmwiX86LwrQxwCsp5LktFfFT8NEG3BdEhBmGFJJ9uNoite+Oxwlo/w9LcBOTosjv0w406R1FOVS3noaIrm+6QS7sZBqIjKxImfLz771HjeeIP9cOgcVeJEhO9dNUdBEK/2WciZF//CgqqTRaIv610k8rZ23GGmqJP7m1wO5Q2/Nj6In4H08AIAxwOyEGy8hppvvL/Z2kvjaMeDXXGdcrTxlen44HOf6twbPAw/gnPOgBjU2Zb6y4XyEXdF0yKsfK8tqo6SkkHGWRvltqxbh/q6QuuXovwVlvTaTyADvsuJUBXJ2D9SW0TRZFG4fYfDMihW/07jRtfNBiKl0AwpDUL0rjz/Jo2pM6SCmDFeoEGma
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199021)(86362001)(33656002)(2906002)(38070700005)(55016003)(966005)(9686003)(83380400001)(186003)(6506007)(26005)(52536014)(38100700002)(7696005)(54906003)(66556008)(122000001)(66476007)(66946007)(76116006)(66446008)(64756008)(6916009)(4326008)(316002)(41300700001)(71200400001)(8676002)(478600001)(5660300002)(8936002)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UExTK2RSVlNxcUxzeXhWOVkzRVhqZ01SRU1NSjhKZWhtNDNUcURtQ0di?=
 =?iso-2022-jp?B?cmppQzFNZHZCNU5DN0syM001aTNscWxOSFFGKzN5S0EyYWlMT25yTncx?=
 =?iso-2022-jp?B?bCsrUXdzZmZsTGxINE1HZGtIR3RlQVZzenF0MitsNFpoaURWbzFjTHdT?=
 =?iso-2022-jp?B?cVh5ZzFKS1JzRmhWbHdlZ3gyN3FiWndwSUZ1Y1g3Vk9hQnBkMG4yNFZL?=
 =?iso-2022-jp?B?YzgxckRaSURiL2tiUlBMMm1GV0c3VWNSV3I5SFpwWEhLR0kwdTlTZzZ3?=
 =?iso-2022-jp?B?ZkRScnRZWkFYK1hxbk1McG5YUmNiWnBLRnQwUXBiekN5K2FTUkZLWFBI?=
 =?iso-2022-jp?B?T3FIUzFIMjViSURPdnlJR1BCV0xmbFpoUDdaNEc2WWRhS2ZzS1VDQXR4?=
 =?iso-2022-jp?B?SkpUTkpGVFYxNFpjRE5ZaW53TTluc0wxWEVPVVh0TnYyVGZvTy80TFJW?=
 =?iso-2022-jp?B?aWxjTG9RVS85UHZoY1ZnQ01LY2F1QkFTWURxMVh4TUFMdTYxbmVBdlVy?=
 =?iso-2022-jp?B?MjRzY2N3K0RSU0tQenF1YmFmSTMyVk0vaWFWa2kyS3FoYnpzTk1PbHVn?=
 =?iso-2022-jp?B?enZ4WXBrV0l1eVlyWmdoMTdzWHhONEUxUGNULzdUMWIrZXhGbnUzbTEy?=
 =?iso-2022-jp?B?UzV6Nkh2YjE5dWozOGt0c1hBb1IwTHI4Z2d4TnVDc3RxYVp4M2huZWRZ?=
 =?iso-2022-jp?B?K3JjU09JU0VEMi93OGFCQ0wveFRDcEVUWHJObDAwTGkyNWhiQ3dSRUR1?=
 =?iso-2022-jp?B?ZlRMdzBIbUM3Z3M0K0UrZmw2cThUM1hNRXgzcUVvV2RRV09ZNkUzSzJy?=
 =?iso-2022-jp?B?S0RQZWViMzVOMWozQUVhZEJJdTFTSjlIem0rYUpVUURud0lzcW12UjJR?=
 =?iso-2022-jp?B?eWtKNjRjWkRZZTRTRHZUdTVBQ3JuN0duZUM3S2xYaW82QWpDWFc3cFVv?=
 =?iso-2022-jp?B?OXRDSlBTQjhjZlA5bzFIQ2F3c2dJWDRZYVFIdGE2ZVdWdzdEL0dheERh?=
 =?iso-2022-jp?B?UWdXUElQMUlNdkJCeWdKdlpMSVo4d2tDTkxkUFVBQmV6SjBUY0pGb05p?=
 =?iso-2022-jp?B?Sm1YSzNMTW5sMHg3RHEzS1ptdkdLWEpNRHVZek1ORHFjRFczdlg5anQx?=
 =?iso-2022-jp?B?TEYzdjBrU3dWeWYxOWwxK2NRYjM4ZjI5YVVuYzVFVjdDKytVVUtTVWJk?=
 =?iso-2022-jp?B?YTMzR2c0Z1ZhSjVwRlpIUTdrYjRUY3hna25nSnZXc3ZJaE84aVlUdDVl?=
 =?iso-2022-jp?B?anNhSkREMS9OR2Z5ZC9lS1QzaEYvUEV2cCt2VytuVHRLejV2U0x5OW93?=
 =?iso-2022-jp?B?OTFEdUFTcVUxTHAxT0cyNXNFUVNqQzZpMmg0N3JoVDZZSkVINGZZcHFD?=
 =?iso-2022-jp?B?aGVIVXJwODVoMTJjT1JtT2xLVVZYNlFUODF3YVZOWTFxbSt4YXdQOUs4?=
 =?iso-2022-jp?B?N2tCRFV5ZjY0MVh5WFg3akpIU0hYd1VNUG9VSSt0Vm5xZS9nYVFQZmRy?=
 =?iso-2022-jp?B?cnZmVnp0OVJTekJrQTBzYlN5Q0pnZ0dDSkE5Y0FFcTlOMmsxZ2gzY25D?=
 =?iso-2022-jp?B?T3l6bmlUbWRXeW1TYnkxOEpQaG4zM0l6K1UxUkRmeUltR1JSNktpeWhK?=
 =?iso-2022-jp?B?TzRMUE10WWR4akx5NUdNdDl6c1hZM2VSWlEydFIrcm9LSENIMnIxdE1U?=
 =?iso-2022-jp?B?c1NtSzk5aFpKRFdOSDBwenc1MlU2TzN1Rkw2eG82YkNGcHhENWdOL3pa?=
 =?iso-2022-jp?B?YlJ0enEyRm1WWG4zMEVvTXVGM01oTkxBWmQ4QmR2OG5JdHNLNzE5R2gy?=
 =?iso-2022-jp?B?UlZ1aXRNWkw2VEgzT0sxcDZiZWhoMncrQkVSNFgwYko4aTIzd281NFcx?=
 =?iso-2022-jp?B?Y3ZEMFJBNHhGRDg1cXh6TU5wcjA4NjFjTGRJakMrcDlEZ1RjSU9NaytO?=
 =?iso-2022-jp?B?a1VCdDlsSWdseG1tNVRhZm5MM1EwLzR2dVY5K3p6VEtLUlI1ejZoVkht?=
 =?iso-2022-jp?B?bk5ISjE3SExQRUZPSDFCTUVEOVB1VTBSL2NSckQzdmMwZkp3T2YxYlVo?=
 =?iso-2022-jp?B?aGZMZ1ZFVUFCNHdsT3VCM3o3ZkJqcyt5eU1Dd0VNTm9iTUUxU25zSHlP?=
 =?iso-2022-jp?B?R1ludnZDSTQ2ZlFuZUpZNVQ2YnZrRDcwMUllREV4M0lpR2p0eFFCRGtE?=
 =?iso-2022-jp?B?MkNoRUhoMDl6TWRwK1Mxb2h2cC9XRmpQL0dwMXlRUi90NitNMDY0dlNW?=
 =?iso-2022-jp?B?VUpHczFNbzB5bzhpV1pvc0pBMmlyTGNUM1ZIMFBkQW1kL1RZaWpRNlFW?=
 =?iso-2022-jp?B?Y1lObWJQeGVEQ3JQWUwxU3dsaWxkVStDWFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?iso-2022-jp?B?cnFWREI5em5Gb0lxSUdVaXVTSzd1cjZLaC84dFdFc1MrZlVkV2JyQjU1?=
 =?iso-2022-jp?B?L3Z0YTZ2djVObldyV2gxdThGOXpKVGN0b05RK3BkY0tYeTBvMWFvWkZ1?=
 =?iso-2022-jp?B?Ym9ZMWhHSnRDU1dUZ3gzZmVCRFkyeGhaT2JaSk1ab3hORk9pSnhCNVFE?=
 =?iso-2022-jp?B?R3p0czF1RUphZURLeTA2UTh0M3UvQnJLWlMrZFhvdlY0WG5XWk9pVUVJ?=
 =?iso-2022-jp?B?aDMybFhCenRHcjllNUhwUDNEV3ZJL1l6eTF6Z3RlLzJ0WVdQVzlhTmtm?=
 =?iso-2022-jp?B?eko3bXRjM09NaEgxNmR1WkV0ZDhrS3UvZXFaeHlSa2tZWVlGc0xyWWRH?=
 =?iso-2022-jp?B?QlgxYkRCU201b3BvR0U1VTl4czFPcmk3Qm1RSU9NUjNXOWVyYnlPZllH?=
 =?iso-2022-jp?B?enAvblFDeUlLQVY5SUVCdXNnMG1NakRjWnBKUTh4azYxQjNPb1hrU1dt?=
 =?iso-2022-jp?B?c1VoZ0tjSXAwelRyTTZCekt3TjlzTDkyZ0t2QStwWlJFV2FTNEJKL3gw?=
 =?iso-2022-jp?B?LzVPeWhQWkhCZnRiQ3N6WlhHTUlYbStvNnZXTUFiNjBUSkE4UERaOTVG?=
 =?iso-2022-jp?B?WDNJbmZuTExQaVpRU0tuQWVmaEo2VEJ3eFBJUTIyVkNmVTdveEpqekI5?=
 =?iso-2022-jp?B?SzVzZVhIZ3NpSWFmbmFjMjhXZFZidlQ1UTJWL1Y3YTdiZzloRnNlaFM3?=
 =?iso-2022-jp?B?Nk4rRTlVOWQvMlpFZFZKM3B0bEZ2b21naDlpV2plT2xXdkx5VEZHSnNE?=
 =?iso-2022-jp?B?b3dtNHd1T01wa3BlWndDeFVCZkFGMmRzbnhTZVlrMSt1ZVhJcFRPZ2xG?=
 =?iso-2022-jp?B?c0hNZGZRVHNNQU5HSk15Zkd5N0l2VVhvT29yVndIVmJuVVNTYlpiYVg1?=
 =?iso-2022-jp?B?WnVkVkc2UEF0czFNcm9xYlBnNjBhNmF5UlRaME41UGltK29zaEFpNE9W?=
 =?iso-2022-jp?B?ak1rV25JdWNBdFpjQ3FCUWUzVEpoYS8zb05KT2Jpdm9kbktvNDNvUml0?=
 =?iso-2022-jp?B?ZzdCYXZCZHBnK3A2UEpGWDBxVTZhNkRhZHlWM1RYZE1PbzlNeEk5dXc4?=
 =?iso-2022-jp?B?TlRhSjYybStHU1drYWpLdGhHUkZYNE5YY2RmSnU3alA1ak1vbHNEMFhr?=
 =?iso-2022-jp?B?WE8wSVltaXIvR2w5RDk5TkZqRmt3Nm0vdmZ2cjZDd3Z5WXg3cXlBSjZ5?=
 =?iso-2022-jp?B?Q2ZubXhLNG5QVlB2T3ZGaU8rT1pIRG1yQkVuQW1tbjlvYzdVcmtXcXk5?=
 =?iso-2022-jp?B?WDMyOE9FVjBzVi90ZHBYYW1IM0ZXSTZnSEFQS0V3VmRkYVBpYkh0ekds?=
 =?iso-2022-jp?B?bElrT3Q0ejloZitUd3dMZGRTS2t5YUFSU3dhZkRMUGkyS0dpVFh5S0Np?=
 =?iso-2022-jp?B?a0p0WnhuQnZ1bWRIcjNvdz09?=
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9cd516f-e08d-4527-c557-08db8450a362
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 09:56:47.6426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0MYF8x8KyuVjlcxJl3NXddhneHvTZqti5uL94dH4C3iGWa6NLo1T/uR9EIUrT7YasF2usdyBd1TJ/UDtEHtL2OoZc5TvbxU4DRTuLyKrQNU/KmRl4gQ9egCB7S4ZJF3p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9424
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Jul 2023 09:57:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12346

Hi all,

CIP kernel team has released Linux kernel v4.19.288-cip101 and v5.10.186-ci=
p37.=20
The linux-4.19.y-cip tree has been updated base version from v4.19.287 to
v4.19.288, and the linux-5.10.y-cip tree has been updated base version from
v5.10.184 to v5.10.186.
The linux-5.10.y-cip tree included updates PWC, SDHCI, and eMMC for Renesas
ARM64 SoC and board.

You can get this release via the git tree at:

  v4.19.288-cip101:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      9c3f27ca919fea575a3a1c378bd95bcbf2c33ca7
    Fixed CVEs:
      None
    added commits:
      CIP: Bump version suffix to -cip101 after merge from stable

  v5.10.186-cip37:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      34d052461016f3c0015b6ea2363ff54ee247caf2=20
    Fixed CVEs:
      CVE-2022-1015: An out of bounds access was discovered in nf_tables ex=
pression evaluation
      CVE-2023-3609: [net/sched: cls_u32: Fix reference counter leak leadin=
g to overflow]
      CVE-2023-3338: NULL Pointer Dereference in DECnet
      CVE-2023-3389: io_uring: hold uring mutex around poll removal
    added commits:
      CIP: Bump version suffix to -cip37 after merge from stable
      arm64: dts: renesas: rzv2mevk2: Add uSD card and eMMC support
      arm64: dts: renesas: r9a09g011: Add eMMC and SDHI support
      mmc: renesas_sdhi: Add RZ/V2M compatible string
      clk: renesas: r9a09g011: Add SDHI/eMMC clock and reset entries
      dt-bindings: mmc: renesas,sdhi: Document RZ/V2M support
      arm64: dts: renesas: v2mevk2: Add PWC support
      arm64: dts: renesas: r9a09g011: Add PWC support
      soc: renesas: Add PWC support for RZ/V2M
      dt-bindings: soc: renesas: Add RZ/V2M PWC
      usb: gadget: udc: renesas_usb3: Fix RZ/V2M {modprobe,bind} error
      i2c: rzv2m: Disable the operation of unit in case of error
      i2c: rzv2m: Replace lowercase macros with static inline functions
      i2c: rzv2m: Drop extra space

Best regards,
   Nobuhiro


