Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF547C433F5
	for <webhook@archiver.kernel.org>; Sun, 12 Dec 2021 12:11:11 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web11.33473.1639311069353570941
 for <cip-dev@lists.cip-project.org>;
 Sun, 12 Dec 2021 04:11:10 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.153, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 1BCCAnZf025390;
 Sun, 12 Dec 2021 21:10:50 +0900
X-Iguazu-Qid: 34ts03xmhruzkiOlW4
X-Iguazu-QSIG: v=2; s=0; t=1639311049; q=34ts03xmhruzkiOlW4;
 m=/95ABqPO9JZjyUsvRMGyze31aIBhIPtqt8Q+VY61MFk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1510) id 1BCCAkh0036789
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 12 Dec 2021 21:10:46 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 9E783100236;
	Sun, 12 Dec 2021 21:10:46 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 1BCCAkah028243;
	Sun, 12 Dec 2021 21:10:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImfLM9yE42J7Lv+d7+VBpDsWGo12j4+HNq56v8IbmJCXM572pGeTZPEqz6TUIJWtZGS4503L6Tqm/krcIYaRakj4R/8plU8e+FrbXLleXsmbYf0mdiyhvT18Qp7Ue46SMLKKkAAyWCny+xvSLG2aLbb4ZffucFeGtgk0wcRMPIYfCJUcsJbg2nB+fT+yp5GuQqp/dKWXMMqAUPUSEc26lJtgt69YOEtJnPlJ2JBjspPshTzvVIIiJHdJYQrcS/Q9ouoHGd6YRF2qjTDZw4I5kFvIsCgKJAZAYnunmC7JieTcG6bP9Mzcwc3DWEPKiKTIbDTOnSowx70AYFLjkAFhyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDXpIOfr+GnytqaGrYN5jEaMOotLI0DvkiDaDWo4L+M=;
 b=D9c7i+gQeOr8FgltXfrpp34+FFwLhhYunTNjrrHo3NwmLZWcwZQLSQXGKUsnY2clLTjbmZheNKujFfJaNkCFkYSHv+dr0iJxMF07mBl+OyIbEnc8j9LHDTDJOksaaFIl4h5kOlP7rVni56bl2UoC7XcTwknixemdcUDIS45dPlkv01aF5D/V0glr7msZfsvPrYLkNIEOULSR5dr/DV2//DoJz11cLZM2M6Vn6S/qpK7xuS2aIMDpLX/q9uRlvg+R2188nEYtV1o3MJzdN0N7JwMy35IgtKHAL2BMpKAEc2cjYytVu1IofhIgD5N+1IHAAsED8IzsSjOW7zEww32rXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>, <uli@fpond.eu>,
        <Chris.Paterson2@renesas.com>, <alice.ferrazzi@miraclelinux.com>,
        <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release  v4.19.220-cip63 and v4.4.294-cip66
Thread-Topic: [ANNOUNCE] Release  v4.19.220-cip63 and v4.4.294-cip66
Thread-Index: AQHX71C3E4qVCQjdaUiQZyb6/aZscw==
Date: Sun, 12 Dec 2021 12:10:43 +0000
X-TSB-HOP: ON
Message-ID: 
 <TYAPR01MB62529C5B80293A537790741992739@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 0955c705-1243-e962-8380-18a231cfdf23
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e1b1c8a-a3bd-4374-4bb6-08d9bd686c0a
x-ms-traffictypediagnostic: TY2PR01MB2604:EE_
x-microsoft-antispam-prvs: 
 <TY2PR01MB2604905CD8F600ACA04619CF92739@TY2PR01MB2604.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 MWmPDXLVQ70dcoxCZlOiCfc0u2QLJdsBWmf1PxgyxIXEGkTmSOj62rA9YOxyLnXA3qoo7fJD8rOOqgG21lX20hZ8nR82lm6BPM6n/tKDh3TDbO8fZr+9xBF9xT1VzbjNAuHIcmNIFp0aNzw72dhtTfFUBiVheykK6sgmJ0aBuis9C8hOBY3jZJIR/XvTfb9Bo+MkUbmHISc4CPYScVI0FcbZ24702kGM/hHIOx7/4sVfpSme4S/W0TzbSJAVxY5/08IB+dGH0Lxnlc+XgwgR5BhES7Acw2dsazaqzvduz9GKNbgf7JfBia1akgkOgA+CWuLI/vVkFNYsorssktFEUFz31EZGkdZkxReHsxcYxRzofDIqyooN+DIex1+VhIn2uFqL0SJES4b4f+ju5ZvBRlxY0si9Iy8xpqvSxpVTaoPblHRmVTrgS2TeKs+34N3DivO7DF7CCAwOU2HhlJzbn2Suul13AtfbbghAmdwL4wydV4kNOmwtVNQiQDlQCSxfE2S6lMssVeaGkj7jTI5tz6f7NyqsBQqVjA3RdT79P5YSVAi9LyQMzIlFce508O9zqWo4gmz+NvqprSDCkY7vM9L9mwk6qB/0rJN7rdX57q1O8Sy5QPpdOy5PD14TSH+gCefggtIy/FuHvsEFcw2PICNDBmbR3eKvfbhWDUhOPY5fI+YfQfeX08/0sCRrRQa6+rhhiXfKXjNJ45sbcLErX3oTGhGsm2WSW5Eo9/vjFidWW2FfF4gYwqJ7Dk1yHjVRBvdkl54OFpGhanQknS8hG/abw6QLTKKE12njzxSSL3s=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(38100700002)(122000001)(2906002)(6506007)(52536014)(71200400001)(54906003)(33656002)(38070700005)(186003)(66476007)(55016003)(66446008)(9686003)(64756008)(5660300002)(966005)(8676002)(4326008)(8936002)(76116006)(83380400001)(26005)(66946007)(316002)(55236004)(508600001)(66556008)(4744005)(6916009)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UlNkS1Rtcm80Y216V0hsZ2xpbnRPbDd1RFBKMlg1YmhVWEhadE9PRThx?=
 =?iso-2022-jp?B?aWRaenM4WnNUVTgwZXVxaURDZzVBL1FieUJucXhKY2F1NXJHL1RwS3Vj?=
 =?iso-2022-jp?B?bVRHS3MxRmFHU2l5c284YmR4N0x5QlBXajVPbnZIQzNETzZLa3BiaUlB?=
 =?iso-2022-jp?B?aHRWcVZQc1dkaEVzT3hJR3Fkc2JZVzVlVjFYQUd5L2tZVEFTdXY5ZkJu?=
 =?iso-2022-jp?B?ZkQvRm84VW9PMjJXa1YrWHBYVmpDYXNCMklWZDU1bkZuZ1NuZlk3Qi9l?=
 =?iso-2022-jp?B?UUxYRVk5NE9kZWIxeVR0MW5FOTczTTFJODB2TGp4dUxPSG1GOTh6Y2Y3?=
 =?iso-2022-jp?B?aVg2VFJzakt1aTdDM1ZNeGhHbkxDZGN2Z0pXWHFZaW1LK1ZPNTNidnNP?=
 =?iso-2022-jp?B?T1ZhbVpFY083QUxpeFQzMXEwT1ZzNG90b1VrUW9xR0pUT01MUUVtRG9z?=
 =?iso-2022-jp?B?UFF0RnUyeXZiQ0c1c2tUTXlTUThBTlErNVUyS09VNkVYVmZmTzB6a3V2?=
 =?iso-2022-jp?B?ZjlYNDhOd3dIV2lmV05MWFJYMjg0Q1h3ZVdPdHJQYXpOTy9JMVJNN2RU?=
 =?iso-2022-jp?B?T0FGTGlpN1ZUWmRld2x1ZTlGMGQwT1A3Q1RucXF5cWM0Tk1LRUFzZTVX?=
 =?iso-2022-jp?B?NnVaWisrTmFXN0RqMzJCUlF0Q2xPaTZCN1VyUGplUGYwbUV4bE4wdlAv?=
 =?iso-2022-jp?B?bS9qNHpoOWNWL04ydFYvcVVES0JQTnd0WG1VVDhRbHdkV1NhSnJCZzY5?=
 =?iso-2022-jp?B?ajQ2ZDBzaXd6TnVRd3VCTnlFOHVBbEptcVBEeThUWmZOaFpjTUl2Y3BM?=
 =?iso-2022-jp?B?bzczT0NnV0FXZlpQQU1Jd0l5QnZmVWVjTmIrNVlYRWl3QkRNQmhkSWdr?=
 =?iso-2022-jp?B?eW9MS1RZZW05dmVUOVBjb1BmWW5abWZ0SnRJdWE3c2V5dGRmZzhqNkpp?=
 =?iso-2022-jp?B?ZE1UU2p2RlpTMENoWTJ3SHVDL3FPeFRYZE03RlBOMm5wT2pHZnNsWXpO?=
 =?iso-2022-jp?B?V3Zia1A5OGFUMDloaGljSGdzakdsZmdYc1FVNlVlQjFHWGcrb1pjVEt3?=
 =?iso-2022-jp?B?VjZIalVDN1ExTmFjMUN6NWFmUURlNnplTFc1QklTK1hYSFRURnVxWjl4?=
 =?iso-2022-jp?B?SFpvWmNwZHIxMTBQVFJEbFl6VzFlZ3RaaDJtdERINzFSWitwcU90TWoy?=
 =?iso-2022-jp?B?eWtINUM4UE5CSTE4Q2hPb0RzVEVUTC9udjZXa3JUNnVJdFhhQVdjNEdK?=
 =?iso-2022-jp?B?Rk9jSG8yRFVrdE91UjViTkw5ZllNejFiYkJmdkZEODRJYUVNdFFLbncy?=
 =?iso-2022-jp?B?aGlwbjhxRmw4Z1pPZ3QweUVLeGdGR043NnJLS1V3VmpaRWE3ci9mS2RG?=
 =?iso-2022-jp?B?V2ZZRmZsTjU5ZS8rQXMrS3hrVHpON0lvbnMxK2hXQ3dxTXArZkxkVVV2?=
 =?iso-2022-jp?B?SG1jVW5PZG5zenQ3N0VHcGNDVjFERmljRlNSWVF4bHhKZCs1alJyUlk4?=
 =?iso-2022-jp?B?R0g4NkxpTDc0TzIxKzRmZ3JYRHBsb1Ztbi9UV3FWMndybUlSUjBqT3I3?=
 =?iso-2022-jp?B?UGE0VU82ZjdsMDZPMmxBTE1DSmc0TWdDV1lvc28rM2VDZHUzK3dKWXpo?=
 =?iso-2022-jp?B?L1F5akh2VkFTNi9LanBNdHVTUll4Z3hDQmNGNUMwMkNBcTU0RjcvK2hK?=
 =?iso-2022-jp?B?bzhPNWtxbTlsT3NmbkRMSmxBUmZTTDJhWXczZitmTG11a0lVL2xSNVVt?=
 =?iso-2022-jp?B?ME1pTVVGRG10MndUang0ZHZhSEZnOXd1eE54RHc3d3JQRDVWQWRsSGNM?=
 =?iso-2022-jp?B?U2ZkRlZjN0pQUFhobkhaRHRzNjNBQVA2cFUzK3VHMHNmcm5lbXhIU0o4?=
 =?iso-2022-jp?B?c2VUdG5XRjV0Qmo1dzFJVmNFT1I3WWtGMHpBTjI3RC9NNmd3Nk5GY2JI?=
 =?iso-2022-jp?B?YWhCYSt4ZGh6YXBsSkhSbS9uQ1kwUEFHWUdZaFJPQWl3QTBSZ25MNmw5?=
 =?iso-2022-jp?B?b1ZuWE1HcVNCRTZud3ZzcGZVQ09HOG5UaG9IekhteEJGWUg0MTQ4N1JR?=
 =?iso-2022-jp?B?KzhoL2pIbE8ycmdjcitXZmk5REU2SndXWVFEQ0NzTjVYU3NjT2VPNkoy?=
 =?iso-2022-jp?B?ZUtqYWxHdExvbHN0RTE1aldNU1BQeHpUWURLa3dGVEJSL3ZPL2I1S0Fm?=
 =?iso-2022-jp?B?QkNxSUc5ekN5MW5CUktKUDVKK2ZSS05LemlTMXBvWGhIc2x0Sld4SURP?=
 =?iso-2022-jp?B?Q0d4RWRFL055VnVkRGlmZzZBTndBLzdGdGxtZ2dpNlRzL0RQZXlBQVhY?=
 =?iso-2022-jp?B?UFZhbHN0UjI1VEhDV2p0YnZLR3BFRXFSb0ptbmloZjZvZ2NMVlpHU0Ny?=
 =?iso-2022-jp?B?bG9YSmFlSDcwZVd2VzZLaUhJd21uRVBuWHE0Y080VGhGbjhjenJqV3lm?=
 =?iso-2022-jp?B?REc2MncycHNmTFRDK3dOUms2c0hjb2wwNWhzaXArdVV4amhiUTBXS3Fa?=
 =?iso-2022-jp?B?UEdBVGJG?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2e1b1c8a-a3bd-4374-4bb6-08d9bd686c0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2021 12:10:43.5717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 f2EY+LHOSmWLSWP4tCZqr3zk2V0VWMaMY/u2AwknBgRRueYesEVyNfz+JJXFYtK+C1rnqOM887z731BLa8E50j8dj/ZIzMLme52MGxxJepHKerKugy8V56GthT5GmdNG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2604
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 12 Dec 2021 12:11:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7090

Hi all,=0A=
=0A=
CIP kernel team has released Linux kernel v4.19.220-cip63 and v4.4.294-cip6=
6.=0A=
The linux-4.19.y-cip tree has been updated from v4.19.217 to v4.19.220, and=
 the=0A=
linux-4.4.y-cip tree has been updated from v4.4.291 to v4.4.294.=0A=
=0A=
You can get this release via the git tree at:=0A=
=0A=
  v4.19.220-cip63:=0A=
    repository:=0A=
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git=0A=
    branch:=0A=
      linux-4.19.y-cip=0A=
    commit hash:=0A=
      bc72f654ae48bf3e6e3cac96d5ca8bdeebd47330=0A=
    added commits:=0A=
      CIP: Bump version suffix to -cip63 after merge from stable=0A=
=0A=
  v4.4.294-cip66:=0A=
    repository:=0A=
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git=0A=
    branch:=0A=
      linux-4.4.y-cip=0A=
    commit hash:=0A=
      f8a9792915e8ad9f417a6431735e953e944713c7=0A=
    added commits:=0A=
      CIP: Bump version suffix to -cip66 after merge from stable=0A=
=0A=
Best regards,=0A=
  Nobuhiro=


