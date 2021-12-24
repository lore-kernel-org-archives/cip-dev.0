Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C321FC433F5
	for <webhook@archiver.kernel.org>; Fri, 24 Dec 2021 13:14:15 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web08.45059.1640351653400496393
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Dec 2021 05:14:14 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.155, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 1BODDsK6000903;
 Fri, 24 Dec 2021 22:13:54 +0900
X-Iguazu-Qid: 34trXZuAsGAoZj9I4Q
X-Iguazu-QSIG: v=2; s=0; t=1640351634; q=34trXZuAsGAoZj9I4Q;
 m=+FAwVQ21g+JriWyY5aBgTyf8SRh2COU6vkceUvvT6vE=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1513) id 1BODDqfo005429
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 24 Dec 2021 22:13:52 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 2423410013E;
	Fri, 24 Dec 2021 22:13:52 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 1BODDpwr010862;
	Fri, 24 Dec 2021 22:13:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYbApNeC0H8O/szN5JltD/SDU63Av5EoBxN+9UA5NHzLsdT8BD142SScMGq+0NFL02BDehJcS2Z+mqdSlkEBXy7qlhPapxnyl3xXldjkEE8RgiXgsEdpg30gJLTzAQdqtcmUhLoxwlJwKbMzeUlHxNcsn9euyvmkNadLdqa2jaKBftYuvlXvNxIE1ybTx1e+MylZ+kXPBUNrkVVSZFKEC1LB4lV60t1NltTgJF+18WdBQ5N6GODtQPgqUifgJLFqiahxizUItQ8oinmelaAHqwex/qTQpo0Y/vQ+MMkwsB0ydHSGN/NyY1xgnZtYaASmCNSgtA6k/NhJBXXq9qGdoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nI6pPMHmfufAa2M0F9P1FchDKZs+rMab+pe0MpTpZ4=;
 b=I11YxupnIbBLHs77hULp1DqWOvVp+HYplgTy/qsSuygf2e970e0t1i5DCcUUEV7a86cnuAPnsr+sG7zdAdYSuTe9k/TVbNMOQ79ZvWxSKPz0I+v1ugWUyrgW0uJjx+BVgOptRwpIKIQycLBJBRIBtXQ9Z7jAz03Y/qHTNUoSRNE9uM1uJIb4KR+LZuPMbj8Ulgh9E0rCjJN8nBvhygG6vsuBH/3buTG3GqRHOPFKJU+Llc2pezGljb1RuCArlEDfdJX7j1edxUheRlVTat1Xoecg/7lm9IOxFcsA12GdASKGMcDxO/fDbCvAa698W7AjXbAL00NKP80/i3OwmKUiyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <uli@fpond.eu>, <jan.kiszka@siemens.com>,
        <Chris.Paterson2@renesas.com>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v4.19.222-cip64
Thread-Topic: [ANNOUNCE] Release v4.19.222-cip64
Thread-Index: AQHX+MfoV15Bo8lmQUOWhsMytGrpAA==
Date: Fri, 24 Dec 2021 13:13:40 +0000
X-TSB-HOP: ON
Message-ID: 
 <TYAPR01MB62527391A5169F23E23CAE54927F9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 60ddec69-1669-e9bd-42e7-f721c12205a2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 500adee8-7957-4ec3-78eb-08d9c6df33ed
x-ms-traffictypediagnostic: TYBPR01MB5551:EE_
x-microsoft-antispam-prvs: 
 <TYBPR01MB5551E710DE8C23F698305B5B927F9@TYBPR01MB5551.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:393;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 97irFEJjOh3wk7CcNeCqYZyRr3cmQmYI2hhOMleSk0ioifRLqV2HoJ4Oef9eWJbNuc2mplAQaW0vqGlVPDiIpsYWJ1h6BLzHHLm0ExpMcmUyoB3fAI91/OatM8pGD0FVi0mMuDj4D43HuFh8u0ltvIdkIvHtFYl+AV6TFxFfmxhH/DJk90OJ83HnFksGxy1j2T1LCxSLqbcU6Bt5s9+nrEwT3Yfnv1F2H99oVosMpquQJBqiEGJXqulnCRBHss7YF1t8qMYUi8wnUiWvaS1ox5Dg4qx9PMsa0pmJeYSsjxYu2JSrdhj0qAH9mZYGwojjuEDeRnMgGQaMYPq6OX+R51bD47KQGLygPSlRjPBEoe7oyFd3PP2BD9NnpoIIXL5JJm/OjFGrnPAB5OBtiMq32vgl43Yes/8jRZPWbv22hkrjt34f7fYHcnHmbWD4rR/oN5oeTUnV/9rpDd7FbifrwZxAcg+QHOTNoXrN3cTNPTpkdhFcJaMlXyhbQPlXckRSvZOKyJRRr0XsXz/g9Ey1FV5ipxvFQQOWzj20X4jVaqU08PZ9NcyZLljNkaCYaZfSYIT69M/rX86nNBuswBy4zuZKDTScjETMFzEtjgBZ5Yj4A8EzjFLLRtmp7uMg7Lb9AV7xEEoFjz+7LYwdFciVISN9D19hpQ7HmemnSoMVPHuGZTJjfjrfUDnZMYXLy8SEv7NNA73EiVN534C45Uh6/Y1siEnwYe5RuCpa0PxX1uU/KW2QpiK5QKk+MlioAKfWnDk+m1viBlTix6PUy6Md7x6q2meV3PsCyj8R7Ig+ZFI=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(966005)(5660300002)(4326008)(8676002)(38070700005)(55016003)(86362001)(66446008)(52536014)(26005)(64756008)(508600001)(83380400001)(54906003)(76116006)(6506007)(7696005)(2906002)(71200400001)(66946007)(33656002)(6916009)(8936002)(186003)(4744005)(38100700002)(66476007)(9686003)(122000001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?eXl0MUtDMnhGMDhkQ2E0cm9zRXRaeEtjUkFoRE1DemM5K2tlQmt3Mlpr?=
 =?iso-2022-jp?B?Wnc2YWVLMnMrTlhlSWVGaXFUalBTVENaZkVrdDc5T3RVTHpobnQxNDZJ?=
 =?iso-2022-jp?B?dURRckZFbTFpblpHTi9HMmZNbnNlWjVMaUxMaXF2SkI1dXpOZkNXUk1a?=
 =?iso-2022-jp?B?ZW1OMkpNdFJYa0RzVUJQdXpmK0psdGQ1bWtQaXVib01WL2dBc3Z4djZG?=
 =?iso-2022-jp?B?S3RteFFpVnVxZENCeWZYU0FPbEVZT3VsaG43ZmI4TlQ4ZGw4dDE3ODcv?=
 =?iso-2022-jp?B?NDNiTm91aWx3V2VPMUEreXBnL2ZwaVRvVGYwdWRtbzR3Qk9UQm9BZXpI?=
 =?iso-2022-jp?B?YldZYTlybXpsdVFsM0czNUZqZzgyT1YzNE1DTXM5cHVBTlBKcG5CNHBq?=
 =?iso-2022-jp?B?akthbmlaNjhyMm5aNlUzNnVKNkxwQk9QQWhJSC9iTFlmY2M3RGljSEk0?=
 =?iso-2022-jp?B?dFZCK2NBVDVoa1N0NjFpNlkvT2ZKNFZsZVdDSm1hdUJRdlExRVRqaERP?=
 =?iso-2022-jp?B?QlNZSmo0M0J3T3l6Vnpzd1VQNllLb2RwSW1wdHgwdVc5Q2ttZmhncTlP?=
 =?iso-2022-jp?B?VitOajJic0N6ODhHemtteHZrTW9uRFJGb2tmUHJSQ1hncDFPVTZiQ0Nr?=
 =?iso-2022-jp?B?anAxSCtMNUZza0NrL25aNUhTR25qN2ZyZThVbWFwMGsyc3pEZXlNV1BP?=
 =?iso-2022-jp?B?TDB3RzQwekY3dVY0UmE1aTY5Zm96NTg4cHdOSkZ2NTErcTJwQUo0cFVG?=
 =?iso-2022-jp?B?a2oySkZKT1JmZkpES0pmUW1veFAzV3o2eC82VzZzUDhwUXR1aWt0VXg3?=
 =?iso-2022-jp?B?MW1nNnZ1N3RSRXVrclJKRmpkc1VRenZZNVZYUkF6aDl6NEUyakpNbjFR?=
 =?iso-2022-jp?B?bkRNUUp1MnpFVmtaZTBmNzEzazd3NHFWWnRwVVJHZ2pxbFNDRms0bExm?=
 =?iso-2022-jp?B?c3k4cnJPYXdwbHhOMlU4Mld1UTVCem0xVGJEbXNYcmlXSkR5bGRQaCtD?=
 =?iso-2022-jp?B?OXk4cDNuM2dURjZnaVNVWGxscDIwQ3g2NkNUUWhGV2xTQ3RLbFBiS1Vj?=
 =?iso-2022-jp?B?MVEvK2VaRk40MDhoNGFqYi9WWXpMRTdCSnRnK3U4QnphcjRFdjZVeWRG?=
 =?iso-2022-jp?B?dTJYOStFMzA1cWpUZEtvMDRqUkpjRjhHblFvak9jSnQvSW1pWE5sbEE0?=
 =?iso-2022-jp?B?U1B5SmFScnBIMGxnY2NnOGJxYUs4eEo0U1VjdDB5ckNKeDdUS01zSzN1?=
 =?iso-2022-jp?B?ZWJWY0dQSzlpQ1Y1UDhjYVFnNGZIbDNUZmI2a00zWkl0Mlp3NFZZUWtK?=
 =?iso-2022-jp?B?TDRhbW5mYnc5dk85Z0JXb0VIYm0vbGZpWnpvL0xEYUtpYnJReUZBWnRO?=
 =?iso-2022-jp?B?aS9GdnJuOWcwN3NZQlp0Y0pEWWR0MjY2VCtkdGUrZEdxTGljc01wdExy?=
 =?iso-2022-jp?B?UUtrOGhlaU01UWVQNWpuZDNhVVZaTTZKNitqRG9QVDlvdEFWNFZxeFQ3?=
 =?iso-2022-jp?B?Q3p6ZUpJdzI3UkhLVmVGakRUMTNoZG15WnkwSUdJdDVUL2EwdytEMjlt?=
 =?iso-2022-jp?B?YXBHR0ZiRkNrKzcyOGsxdlU2MjV2NFNuVGpLVkoyS2pkM25iRklBbTRV?=
 =?iso-2022-jp?B?K1hpeG9aYmc5V2VaQ1VOTW5CYW55NnZHMXpoQVo5dUpoSSsvMjBGcWpV?=
 =?iso-2022-jp?B?UU9Dd2VSZXhjR05mYm1XNWhzZU5LWWlzM3UyNFgzalREQ3BWemJicjRq?=
 =?iso-2022-jp?B?cjZhS1phbWZSZkZTN0J0WG1JQ1B1YkFFb3VqcFJtUzFOK3ZpOFhLclJ5?=
 =?iso-2022-jp?B?Z1ltSjFhaTFxNFdiNlRyKzlBUXNQNjFRMnNacWJ5NUx3LzVZbk94MkZX?=
 =?iso-2022-jp?B?WGpvaUczVnBPS2xQdEJmaW1ZTko1QjN3RkpxbDVFRnNSRlhOcTJxRHB2?=
 =?iso-2022-jp?B?cm4zQkNXZ2pUNHdGOTYyL1dyeXV4cG9Gbjg5S2N2UTF2Y3U5VUFtMm52?=
 =?iso-2022-jp?B?aUdhQWVuYXBsOUI4ZlVWMHlxZXVaTjRvcU1ac0FXd1c5eGxoeXpZUjFG?=
 =?iso-2022-jp?B?NytreGZ2VG84ZGREMUV5WkpBWmxibzlLSG9aYW0wSndQSnBUOVV4clNW?=
 =?iso-2022-jp?B?S2RMTmR3SzlKeWpyeGo5NWxPS2lwZ0QyUzNvMnZDN0Q0UTh5VU1JZ2I5?=
 =?iso-2022-jp?B?WlpXdmFpclErVWxoREh3TWl0MW80M252dEg4d3U0YW5tZU9ZZzd2bVlo?=
 =?iso-2022-jp?B?bWVkaW9XZ29BUkg2TXdkRG9rcUxNTjJod2NKREhiU3R5RFU0WHp0VEZ0?=
 =?iso-2022-jp?B?UDV4Y2lrVUx0UStGc2w1eW9McFdMOTNFSVJYRU1rUnIrekdGc0JHYm1z?=
 =?iso-2022-jp?B?SitxeDlldWpTSm1pNm1VUW5HYkRNRW95MVdJbysrU0hPUkZaME40TFZZ?=
 =?iso-2022-jp?B?VmRSTllkSWtlUlUzZWNwTWcrZm1hRmdleU1BZ1NuUVo5dFhjQ1hMVXpR?=
 =?iso-2022-jp?B?RXNGcFJW?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 500adee8-7957-4ec3-78eb-08d9c6df33ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2021 13:13:40.0374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 u61tH7cpzodxQet641kJ19laZwiTK0OvqpOL3p8xkpqNSP5S8se00O8hDaso2hPaXPTsUzSuopNXDQioZwb6SQ5CSKw+2Q/6sY1BKM8ktk1lv+J7zCJ1mk1AUU6ymxsH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5551
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Dec 2021 13:14:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7269

Hi all,=0A=
=0A=
CIP kernel team has released Linux kernel v4.19.222-cip64.=0A=
The linux-4.19.y-cip tree has been updated base version from v4.19.220=0A=
to v4.19.222.=0A=
=0A=
You can get this release via the git tree at:=0A=
=0A=
  v4.19.222-cip64:=0A=
    repository:=0A=
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git=0A=
    branch:=0A=
      linux-4.19.y-cip=0A=
    commit hash:=0A=
      3cc384e269b518ae60e439249ece8ae4c189a810=0A=
    Fixed CVEs:=0A=
       - CVE-2021-39685: USB: gadget: detect too-big endpoint 0 requests=0A=
    added commits:=0A=
      CIP: Bump version suffix to -cip64 after merge from stable=0A=
=0A=
Happy holidays.=0A=
   Nobuhiro=0A=
=0A=
--=0A=
Nobuhiro Iwamatsu=


