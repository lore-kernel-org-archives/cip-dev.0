Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD851E743D1
	for <webhook@archiver.kernel.org>; Thu, 28 Sep 2023 23:56:28 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.7181.1695945383232645354
 for <cip-dev@lists.cip-project.org>;
 Thu, 28 Sep 2023 16:56:24 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 38SNu3Lk3974538; Fri, 29 Sep 2023 08:56:03 +0900
X-Iguazu-Qid: 2yAbzM2tf4vyRhPOdf
X-Iguazu-QSIG: v=2; s=0; t=1695945363; q=2yAbzM2tf4vyRhPOdf; m=A+YWGZjATC9dUenMhxMCrmf3Ey54aKzDktChpfZ/Tbo=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 38SNu1GS1591278
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 29 Sep 2023 08:56:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtO+PJvtXnOpcELcN/YznQdz2XIen7Hxr5ygsoVqT+/pVsyGX9sPUanNV9MfymHveAL4ZV7zbrCx73wCgVyYuLQFfM03pDjzdfmcMlzEpbLsgHKR0MWmFduBCmReTZSq0lLUJFraMMnkHs2xaPafO+JlFv7S5HdRnaUvzsXN70gtA2LWzLv4bRJsiqGHC2vOuL4QggUFErX/5csMf5zJmiMWJTQ4m4xtmVWhia2MOqS11jqYPpoGR3KboBxagO19ob7+c6sd3uHxthDeocpq/ViK9UKMTDbz0Rex8UuwYUkH6bdxthrWik/rV+28xWHG04zLluV9jRbjGSlVpFXqDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+xeOCuNOlGLmocGetxB69HVE3Q9aP74yf1liTsgTtA=;
 b=bGX1RCIrjeV+U6XzI4Rpf0L1mNA47X6Csw54LqGhqYD9lkosYfjlJtz/PdCTiHMWakQV1Md4L3bNd4eqT6pJDbFT7zjmSw/DaWbuwFyM0U35m4/U21oMAylWiIHgTzLpsVT0bAR2QOa5gUMvT/jjnnVFsiUYnxBqmG3aN42kTWBpy/HhCr4wFCa3e6/q0+XhRjoK0UWyNt+/uMq0oGrrJna6GRnVQ++17f//HCwqUK31xCet5iewdvConaCHWGoAPbwJw7wePO9e9dvBgmYBR4SOifYJs3Lw9xXlMmAcPHsfXap36HFVR8OBLfocsU6FFzpzUKo6duy2ielYccZBcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>, <uli@fpond.eu>,
        <Chris.Paterson2@renesas.com>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v4.19.295-cip103
Thread-Topic: [ANNOUNCE] Release v4.19.295-cip103
Thread-Index: AdnyZTtQ4gjKO/J1R7GW+cBwdcqC/w==
Date: Thu, 28 Sep 2023 23:55:59 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420573EE8565A4DADA0C10792C1A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|OSYPR01MB5479:EE_
x-ms-office365-filtering-correlation-id: d27518c7-bf07-4203-014a-08dbc07e76fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 10TioT8LeJoCeNgcnE00csNNbFHFVyaKpinXVR7MY4Abv4ZyUNQn1KFleLSr7Z8L7GTAYHqN2TSprdzt6swCBJ56/qjq2x8k3bGb0pg83GFsR0Q/5TgHut92hIic0It2TJYcHXRJp8ZYpe0VTHdakIHa1pg44xZp5xsVpNG5JlarNTtizwNNPW7je1CAex05qxKGzPAv/+tFm1sQHLyme9UCYXS3P81Z2aMegMHLGb4AEP4K7sYlq89DN3pkRJCaQ/a5IsfjUTem5O9nmMBhIYkpx7GbbslwcLfXQ09W36n2tmdHhjxVi2HBLl6/w8gpf1eQ55LphYVhC985Rc68/E8JWgOIrC+Etb5zq7SKe+H7gEGKQXTy+SXOV4MXCCgh6t+JG9DrSR3WrA/VKSt9GJ/4wMpzCcypRE+EDMFmQQUZ4oHRkqwfgt5D2hqXg3W6mR3txTm+499uvduIvdVK4Gv8BPJJUpaxyoyHkRxUvyl9+lBRyb8bVZ9QAFgASEypKWRI6Kj5Dtf8RrUTPc5JSBk815egTp2KvO/vtN4SOVVEk+0f+rnDhOVJDYrFfPqMiIhgNwuvXwYhEIm9YCLPjE+rilgS+0GV03Awif2mQTWhlKYsCkyjU7zKG75JcpAr
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(396003)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(9686003)(7696005)(6506007)(71200400001)(478600001)(966005)(83380400001)(26005)(2906002)(66446008)(6916009)(66946007)(76116006)(66556008)(66476007)(316002)(54906003)(64756008)(52536014)(5660300002)(8676002)(8936002)(4326008)(41300700001)(33656002)(86362001)(122000001)(55016003)(38100700002)(38070700005)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Mk5uRVZmOFdpaVZYWkY5b2l6N2RIM0hhbEJCM1VFUGpRU044MnpERkwz?=
 =?iso-2022-jp?B?a2E2bzZmSlJxT0pvUW13ZW81bDlIUU5WYmw1eURHZm9FZk9KWkl3aklt?=
 =?iso-2022-jp?B?ZUZxZXRrZkFDOVcrU2djYW1xQ2JWSFdWSWN4YVhRL0k1T09nY3lKUnN0?=
 =?iso-2022-jp?B?bFY3WGxKNlVTQ3oweS9jMXE5ZkJLN29vWXAxYjlaMGhpSEtHc2RHbjBG?=
 =?iso-2022-jp?B?SzNuRWMrVGlXdzFicXg5MlpoNGNtckJ1TFpKUDNxUWRKckhmWDRuREdj?=
 =?iso-2022-jp?B?cnluTHUzbE9HOFlqSGpsRzE1MkZlTUZPMHpnRm9FbVVtWlpLNE5jSFdv?=
 =?iso-2022-jp?B?MDRqZkU1b2RZaHYzaFVIa1BBblREVWJlVzFxWGwxTnhXbGc1OVlTemFp?=
 =?iso-2022-jp?B?MlVMTHVPSUhKL1luTjBYVDI1Y2ZCWVp2NHpnK2pYVkZaMXE3VENOWGtU?=
 =?iso-2022-jp?B?TlgrR28xekRkOEhBZk45MUJiZjh2aXI3UEFiN0EwWnFMN285eDkvUTR6?=
 =?iso-2022-jp?B?VS9xS25CUVlMem1tVHFacHprRGRmdk9nWlg2eDNwdEhGOTRpRkNYWjN5?=
 =?iso-2022-jp?B?c2dxK0kxSzUwQjUvOWo2bldsWjVQZisva1pTSi9TUU9NczVNMlhab1Jn?=
 =?iso-2022-jp?B?dVFrTjM3YU1IaFNPTEcyalhEOTh4TGRSWkI1QUl5YUhxUWxWblhyQ2wx?=
 =?iso-2022-jp?B?QU5VbWRMRWNMTGxJUVAyY3AraDk5LzhkN0Y4blRhV1FJTHlrYmRDa1Zj?=
 =?iso-2022-jp?B?dTJGeVk1RlZGSkp0bVRTcExZaFFadEFyeDFiYzRiMHBzeGNzRGloa0NW?=
 =?iso-2022-jp?B?Y0l3NmRBMDg4SVJHeXpCQ3B4TE1OemNpN1Y4UExDUVBuVTdBVVJXcHN1?=
 =?iso-2022-jp?B?NlNueXFzQmJxRDF2Qmo1Y3lWYXBlbVVXbjE1eGpnakM3cDVldXhJWWh6?=
 =?iso-2022-jp?B?MUJxRFQ3RjFocHFwdlhxQTNlemJCMDE4WVZEb1g3VWViZVBmTzE4STdt?=
 =?iso-2022-jp?B?eW1jcWxwUDhCSDBQNDJacFFvMkVKWkVFWUlkZVNDQ0wzZzBiWGVTU2NC?=
 =?iso-2022-jp?B?ZU9hSXhrUnJTbC9Ga0hOWEhmMjBvSmZJR3ZQb2hDLzI0RGV0WEZNRjNL?=
 =?iso-2022-jp?B?NlZZOXlTNnA3aWYrOHFJOUNFVHhHaGdLRkgvK0VzQ3hEU0FpU2t5MTlW?=
 =?iso-2022-jp?B?UEVoUlhDRDM2ZHFHV1czOFZKZWRGWkZqbHdxcHJQeUhSYnpuVmRjWkpz?=
 =?iso-2022-jp?B?NStjVGgveEhzMjN2dXpGSUwwYlJpZWk2NCtZZG5jRTFrekZiblNrQVFC?=
 =?iso-2022-jp?B?djY0RnUzbzhMVXVUakY1ZjBrSG41Q3I2SGJsdCtzWkNyR1c4bDlEdGRQ?=
 =?iso-2022-jp?B?REV6ZUszR1VtdmpuVzVVZ3lHcFg5TXNpa2NrWDFuVGtTTEVMT3p1U1B3?=
 =?iso-2022-jp?B?TCtlNGFuaWxjUWNnREtqbzZTbjdCQkRQQWY0S2NqWTdieGZFT2E0bG9z?=
 =?iso-2022-jp?B?YUIzN251c1F3NG96ZWlhckk1S2pZeGh0b3MrcUpQY0I5QVFYS1hWZXVy?=
 =?iso-2022-jp?B?Um0zblFWc3NqblR0dGtiYUgrKzRxNFJDbWZWR3gwUVBEQXZBbW5IUnhm?=
 =?iso-2022-jp?B?UVN0cDZodDhHcnlXTmFEcDJkTldhRGxpdnRQNFpkbXJZSE1vQ0g1eXpK?=
 =?iso-2022-jp?B?b0w1WHZjQ2hYdVhLSE1oRVhCT0NQU3dKc3E5NzBwTWNHUElicG41QnRT?=
 =?iso-2022-jp?B?b0RoalljWDlEOXE1RXNTQVhsSk8rVmZoVzFvZEFra2MzKzM1NS9yclBp?=
 =?iso-2022-jp?B?S2NTMW4zMHdyZnBpV1BqbGJYVkNRaWNCOEpodm15RVV3a0pzVzZBTjdO?=
 =?iso-2022-jp?B?alUwQmxYZUZ6MHd1dk9YSnZLYVJEeFNnYkdVNnhxNndidFRoMlJaWVR1?=
 =?iso-2022-jp?B?TFdsaUtXN2xDU0JCalhaUWVjWkljU29RRkxqbkFUTG16YytISVFTTHdk?=
 =?iso-2022-jp?B?b2d4Y0dYVDhvMSt5L1VjUXlkME4rS1JRa1gxeld6TGdnaTZZQmk4bTN5?=
 =?iso-2022-jp?B?WTRBTmY1TnNJbzdIR0JvLzB0UVkrdk9HMnRlWDNPYXhNVDNQUWtYU25x?=
 =?iso-2022-jp?B?NmFtOXhpUGNHRDZnT1EvbEswM0dld0xNSDhLcEI3bldVRHZQcjg0S0Rh?=
 =?iso-2022-jp?B?NmhHWVFJdm0vZmJxdmZwczgyRUdZTjEwT29tY0RHcEpXR3JJQ01VRjd6?=
 =?iso-2022-jp?B?L1lSSnNRUnNzV1ZPaDR6VVFyQ3g0NEFNWUR6VGlJVzdET2F3VTErTWdu?=
 =?iso-2022-jp?B?R2poNmROcE5ZMU1pSXFmdFFJbWNsSjF2bXc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d27518c7-bf07-4203-014a-08dbc07e76fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 23:55:59.7455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zqIAhx2nJKpzk1+Q91A5ATH+Hs9DUsD8BiCGXw4/R1owYf3ZzOAy3VexNWx4S/Uyuve5uA/0x3s/ytUnmfy5J02Txbz4DYJYQItniWiVczmWPOn+O9y6A8JfVwkTSJpn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5479
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Sep 2023 23:56:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13246

Hi all,

CIP kernel team has released Linux kernel v4.19.295-cip103.
The linux-4.19.y-cip tree has been updated base version from v4.19.292 to v=
4.19.295,

You can get this release via the git tree at:

  v4.19.295-cip103:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      f0bb9fab6f834f73d3a71af029f5bda19d99b33c
    Fixed CVEs:
      CVE-2023-1989: Bluetooth: btsdio: fix use after free bug in btsdio_re=
move due to unfinished work
      CVE-2023-4623: net/sched: sch_hfsc: Ensure inner classes have fsc cur=
ve
      CVE-2023-4128: net/sched: Use-after-free vulnerabilities in the net/s=
ched classifiers: cls_fw, cls_u32 and cls_route
      CVE-2023-4921: net: sched: sch_qfq: Fix UAF in qfq_dequeue()
      CVE-2023-4207: net/sched: cls_fw: No longer copy tcf_result on update=
 to avoid use-after-free
      CVE-2023-42755: wild pointer access in rsvp classifer in the Linux ke=
rnel
      CVE-2023-42753: netfilter: ipset: add the missing IP_SET_HASH_WITH_NE=
T0 macro for ip_set_hash_netportnet.c
      CVE-2023-42752: igmp: limit igmpv3_newpack() packet size to IP_MAX_MT=
U
      CVE-2023-4622: af_unix: Fix null-ptr-deref in unix_stream_sendpage().
      CVE-2023-3772: xfrm: add NULL check in xfrm_update_ae_params
      CVE-2023-1077: sched/rt: pick_next_rt_entity(): check list_entry
    added commits:
      CIP: Bump version suffix to -cip103 after merge from stable

Best regards,
   Nobuhiro


