Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FD7C74A5B
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 05:45:11 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web10.36237.1679463909828038860
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Mar 2023 22:45:10 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.157, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 32M5ii32018936; Wed, 22 Mar 2023 14:44:45 +0900
X-Iguazu-Qid: 2wHHJG9eMKIZKMF2SB
X-Iguazu-QSIG: v=2; s=0; t=1679463884; q=2wHHJG9eMKIZKMF2SB; m=1ZhR/3n7vnzI+BzqH3kUew2JpFSIzvdxQQ/TNV9tulo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1110) id 32M5ie2R040922
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 22 Mar 2023 14:44:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aiI/I5fP1nycKUaXre9bWs1ZKwJracQbi0RKRnDlSgkPbzlwz4tHSkUfGnaEESxnJy5lAxlKm1tSZGWPa2rXE6vgKAqT44KGXGFspjP1A9HdStvK/EOhSUyvvSzEPK8xAe6OBIk0P2Zb4X9YTjEHmeP6DTjS1xykey3RtvvQ7PKfzFF/0hU8yC90b02F3hKuyN8dlDA+wkJPEekS24/J7aIGZVc15ARgRXY6JHRMo9/HJcQHTipYcZ4CgY1cNEDbcURlQaehseGwlpiBywWGn3D5OBSE6kZ4QKOxYS6xt6FUcI+IGWJx7OMteVKZKuxZnvbZAGBGZuRA9t3/8Pyy+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pO0f14Fp2BZFDvORHBmrE/2EvWrgwXnlpuw/aW3X5cQ=;
 b=k6p0Q/01mgFHqnwjSFylpnWZqMXSwsZWeVdedE3b85yKfDgJscVpzqlaEnBwXKs925f7n02Y0zPxozEVCs+1ekXtdqAKg5N8WkdQ/v4mMe9zG5AiIWwIOCoRqCzZo63Ir79J8GntKXf4JR3kdQWwbqE+K94lPkOKNY6mz96hHf6g00gK5WtvGZfB3whetsRtdg7VTU1cAjlUvXPqWdX17HyJ/ExUkmeuR0BbCFhV2B0O6HxsRXU+sW0tvdP48T1/rdmv9vgrVrtWtAVWwYq8fHysGmHdwkXFN5qWAckOF4vKc08M8H3VagB7mGejwU1iR8OqyjclVJd5sEt93QyB0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <uli@fpond.eu>, <jan.kiszka@siemens.com>,
        <masami.ichikawa@cybertrust.co.jp>, <Chris.Paterson2@renesas.com>
Subject: [ANNOUNCE] Release v4.19.277-cip94 and v5.10.175-cip29
Thread-Topic: [ANNOUNCE] Release v4.19.277-cip94 and v5.10.175-cip29
Thread-Index: AdlcgPPrzryI1WNsTzaiFNRj0Cqwnw==
Date: Wed, 22 Mar 2023 05:44:37 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB94204A81EFB835ADDB0BE6F492869@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYWPR01MB11273:EE_
x-ms-office365-filtering-correlation-id: f433329e-c753-4f4c-fd17-08db2a98865b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EuT2U92pZyedeneAx1qIG4EyuVwy//+iCzdSQHvrpu5kZA9gVHqL7UgwGVG5wf5uODRV0QkCBusE3uYhmAefwr/xOQ6vebfl0FtwUFkAMGF/rVkDVqYG13mhy+8IkUBrG7qV3/tFrxmtmCOnf2f+HDvb3UtO0wOHNpwlJ18Pakko1vT3mDDdR6WJ5ztiAoqyZmXfQoK8RpAYcIUSJpGeafskqA/HmfcRPxflumx4P9ua4myMVbbwQmaz54A5DajKWpAxDLgNCYstNVYpEgGZY9bRMXUka/PjRzmUT6AuJEdM7APDluQoRmv5qV/9KVwQEmIi1yjlwtXt3HfmjQehtiD+B4mRyCOiriwPgvDfvwmL1nQaH5p+vp25qnaW3o3wJpKb/gMcrlXlK/43Yn0se4Ck4mteSgrd5FD+yr+bDuVnkoqa8H78on+gUEn9plMQhl1TSdUwWRpDMeLdrFZBaMKnt6EU1TWBL81/yy0FlzuILjCWLez0qO2bvopDYSpSjG66hN41ik2Wv9nGy5x5WTVTDRUHjvWBrjOBhaUVrxtt31v9QaF6db+6qywz9wQggXOrZYAMWZ6uwgU3Wl70+WICEm7AvGbTlqfxkEUEdgUGa0ECg6qDJtMGUbAPGEJKf9DbvXkdK29DyFTl+hReoUoSs5BJx+Cqy7kx+kfqs4ARIspM+cQCK9VUCbUPAqn/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199018)(7696005)(54906003)(33656002)(966005)(6506007)(316002)(478600001)(26005)(5660300002)(9686003)(186003)(83380400001)(122000001)(71200400001)(38100700002)(86362001)(55016003)(38070700005)(66946007)(4744005)(6916009)(52536014)(76116006)(41300700001)(2906002)(64756008)(66476007)(8676002)(4326008)(66556008)(66446008)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?N3VrMDdhQ1BkeUpvYkJZaXIvZy82SElzWWl5TDVYTXZDMzdVYjFicGNv?=
 =?iso-2022-jp?B?UUtjWWRZeE5hUHRtUDZtVlRiRXVOQW1OQ2RuM0sxaUp5MjZ3REFHSjhj?=
 =?iso-2022-jp?B?alhLcTEvd0hoTHNTU2NaWmpZVlMvU3ZyZVUramg5UjVEenFCdmFyMUkr?=
 =?iso-2022-jp?B?WDU0SloycVBPTlpXSngxZ2dRTFhIdndYUFVRNHNJZFN6Vzl3bmFYMitN?=
 =?iso-2022-jp?B?VnEvMkFuL21PWE5yc1lJcjQ5aDhKempCdUc1S09vN0puZmFJUHM1c2Z3?=
 =?iso-2022-jp?B?U2Y0RVdBd1ZJenFLdDlVd2JnbWpmWTNVaXAxd1lzRndZQ3doRGUwNWho?=
 =?iso-2022-jp?B?Q0FjUk5oMkpvL3VrVFJwSHp3b2tPRzIzNnc0TkJiUDJpSUNMblg0N282?=
 =?iso-2022-jp?B?V0NXclE2ZDFndWJrekpMRVVQSkdaZk52d3AwamJiVVZaVFAxMXZHQ2No?=
 =?iso-2022-jp?B?VlVWajhHVjNSZnN4TGpoSS9EdGEzYWg0ZW8rVVlOL3l0ckRCUU1DeU8r?=
 =?iso-2022-jp?B?N2VSNk1LRS9NOUg3T2hWYVd2YWtrUndWdDhzd0xSNlg5c0JVWGlFaThX?=
 =?iso-2022-jp?B?M3MxZHYzWW9vbHdYblB3MElyTUtyZU91YWdBU2VxZllydTJjcEJGOWxY?=
 =?iso-2022-jp?B?RFAzbkhWZHY1bmNnSGJTMGlaNUdmTW52R1lGZlRsRVZGYkk1N3pSMjRT?=
 =?iso-2022-jp?B?dGh0Y2RwRW0wNEl1WXpEK0tNY3l2WGJMZ3lZQmtaU2VpZGFGQnphcmZE?=
 =?iso-2022-jp?B?QmkrWHJUc1g2U3BKbm94bzJnNmhQU2dKckdKOUJiUUFwc1FlVDIzSFpL?=
 =?iso-2022-jp?B?dU54a1hHWTFaZmJWdW85YTRmKzZESzdNM3N2SEg4V0VIbEFRMnV1c0Y5?=
 =?iso-2022-jp?B?Znh6SE43TGc0NjNKcXdjdXdCbHFvMjNWQ2ZvVitTbmlhMU5pYm5kVzFT?=
 =?iso-2022-jp?B?ZDgrSlBEYWxHYnRmZ0h5L2ZaOXY2aUVWNHc5OUc0TFlxVThPaGNJV2x3?=
 =?iso-2022-jp?B?eGF0NXVvNTV3YWFOajRvMWZTTDNQK2RKbzYxOGY1WUNSZHE2T1lBOGRC?=
 =?iso-2022-jp?B?dm4yMDEwL0hhZ3ZHOFFkdTVCMWJUL3pReEpZY082TlYrOCtvRC80REQr?=
 =?iso-2022-jp?B?eHpKNzVteGVNTS94b1NMVUt0RlV0T0UxSCs3c1dwcmxCNFJtSVBtR2M0?=
 =?iso-2022-jp?B?dEhnUnU1d0dNTE1ZVmJrbFBwVUdBTkduU2p0Qm56ak5OcXcvL1lIOEUr?=
 =?iso-2022-jp?B?bzhmREFPM2xieE01YTQzc2ljNEJMWFZEUnhGRXVNU25YMUZpMTgzWDF0?=
 =?iso-2022-jp?B?TXBxVmtGM0UrMWg4UDcyYWdqWUIxUkdQRVI5a1NuSnc3N2JDZURxSVVs?=
 =?iso-2022-jp?B?ck1DNWVkMHBKUUVnVE5iWnovL0dNTUFBS1E3UFVQR3lQS21seEpMZ0E0?=
 =?iso-2022-jp?B?VjRvMmFOYjh5MGJ2dnpYT1oyd0svRVplc2lEcnJ1NWZHVitpSEs5c3VX?=
 =?iso-2022-jp?B?a01Kei9IMEl6UU1BWnBsUTRjS2Z1VHJ3TCtHSXhuVDRwNjVpdjRTYk1E?=
 =?iso-2022-jp?B?ZVFnN29POERQcUxJYjMwNkRhTlFBSVlkYURNQlVDSExYVXNmSlFvQ2tp?=
 =?iso-2022-jp?B?RlUzamNCOTI2WmFjazlZYUxya21iNkkxR20xS0JhaFJSMHZraXk3bHhY?=
 =?iso-2022-jp?B?cWpmMGF5b2VCY1l4Ykh4a0pOaE14YUIyU29qSW5rMkJjMzFuQXJhcTd4?=
 =?iso-2022-jp?B?c3hLREFZNzNwUDQxZlVLVGtRdzRRZFl1R3lUYWZGamFHblozczFXd3BY?=
 =?iso-2022-jp?B?RGorTkg4S21MQTBuaHRCLzVFMUptQU5qdTBwdmxEWTk0QzlQaEtpN0Nt?=
 =?iso-2022-jp?B?WnBtMjB4QjlPdlF5eFB4UThjZzBGd3FFMHo1SHBjWS9JRDJhZ0ljYmtl?=
 =?iso-2022-jp?B?cFhoSWNoQW1HM0hvSU5vemRWRzFZN1REdjJvcnp2WStqQ29uZ1M0UktN?=
 =?iso-2022-jp?B?d0wvZVRSN2l3WEpOUVRabENwcHlhaHVKT1p2NkNKTFRGQUxFZVRDcTJR?=
 =?iso-2022-jp?B?K09QV29BK0d6VWNFcjUzL2NiNm5LZ3RPenNRUThLZGF6WVpudXBIeHBP?=
 =?iso-2022-jp?B?R3dxWmcvY3pIRXRiSnJMK2ludUdNYzUxSGFqNnZNL3p5K1pSWTlQMitl?=
 =?iso-2022-jp?B?ZDM4a3lTZVZ3WFZrdW40SWdyc2R5Q0dza2ZSaVRCM1M4SlM0SjVDUXE0?=
 =?iso-2022-jp?B?RTRkcFRSQWN0dWVoN3kza001UWJBM2lJaTNFYWJSZ2duRk9hUC9TZ1lD?=
 =?iso-2022-jp?B?ZUhNK3NYaWtrOTNub1Y4UlF1ME1OaTZCaFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f433329e-c753-4f4c-fd17-08db2a98865b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 05:44:38.0003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: amhw1ihT0i8ZEYC4wTDYV1fdOJzCOfCw10nr8neXid+LDECgMMczda/HPhcVGUdZYN6gTiE9dZYRg7T16zFZ6bfrfFnEEVwnfNnlrvYzX2IrJGVogBfM/78oNR4HjXoU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11273
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 05:45:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11042

Hi all,

CIP kernel team has released Linux kernel v4.19.277-cip94 and v5.10.175-cip=
29.
This is a release to facilitate the cip-rt release.

The linux-4.19.y-cip tree has been updated base version from v4.19.276 to
v4.19.277, and the linux-5.10.y-cip tree has been updated base version from
v5.10.173 to v5.10.175.

You can get this release via the git tree at:

  v4.19.277-cip94:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      7027f305d14858b8392890a56cfe71edd50df202
    Fixed CVEs:
      None
    added commits:
      CIP: Bump version suffix to -cip94 after merge from stable

  v5.10.175-cip29:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      bb7267e6d2a6f131bb46ba14f0d3c418379e8bd4
    Fixed CVEs:
      None
    added commits:
      CIP: Bump version suffix to -cip29 after merge from stable

Best regards,
   Nobuhiro


