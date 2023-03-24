Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671C1C76195
	for <webhook@archiver.kernel.org>; Fri, 24 Mar 2023 07:53:05 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web11.95395.1679644378976576016
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Mar 2023 00:52:59 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.155, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 32O7qe5j001370; Fri, 24 Mar 2023 16:52:40 +0900
X-Iguazu-Qid: 34trKxHUqtVasf2VHh
X-Iguazu-QSIG: v=2; s=0; t=1679644360; q=34trKxHUqtVasf2VHh; m=zfsmFho4K6ykOTRL5Vsxb0bXat2+bnThg2p44yRo5TU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1513) id 32O7qcPv015032
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 24 Mar 2023 16:52:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBsOVMAerXqlW5CBToSbziRlAM+9zNI4IzHMy5k0PHyJN8z8TQ2lSRr9Me6ntU8C6bm9Ko1kZHMX/qZQDI17Q9NXPhcrkLsXj1m6vdr7+i55I1CzdvU4Zj21MK9V90zj3bxp1wjpTvESIaTD0Yd8D8RUyKmnmDInLH6lZfYgR/EZyiJjZUiEo6r4j8HcGZGBGR7zpL+qrYo54t7XUeWvcdHttDwmSDHHpuduLLHYzXniKFhIrpNYc44bxfdA9reyoXXALcSyyZLgT3I+NiXc4C5f/ELwRRInWovPG2tFhxNAltlk+i7BMALcUGi0TSZXxUfiibVNCUOcKM6yUtdM7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSz6cFE+usEC1iK+a38w12mR86iHPQT/jcMbUx8anUU=;
 b=XKx8zzrlLk6HKNHPvSA7zRccWEFz032kZaMsi/klL4oLCBmojkeyhoIursmXwjdu67sU3xFIfjIxigIXyDUtgvZp3E8lckSy/hdjJkpkXHswmailhqknfG+jWS3bIDzoRCxZ3MHboOtSIolD7ySK0nKK6ZQX8Ufwby2d1+P5aw8Tg/Y1H7o0JO2Dh9iidnwpTX+Q+SbBrnwRFOde3CKuCbi7Umks97Vx4LoEvAGFCT5eGOX4gdyBDKFPpwhFpiIM54e8tRXkCq9vyYYqdqNiAPGwy7mlcTur+CobQ81d6lvbPTth62ncpGuo5eT8VnlT+fgBtuvM6byGCb/r+jvVlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <uli@fpond.eu>, <jan.kiszka@siemens.com>,
        <masami.ichikawa@cybertrust.co.jp>, <Chris.Paterson2@renesas.com>
Subject: [ANNOUNCE] Release v4.19.279-cip95 and v5.10.176-cip30
Thread-Topic: [ANNOUNCE] Release v4.19.279-cip95 and v5.10.176-cip30
Thread-Index: AdleJXaq1eSVq3O9Rt+UG5vUMhdhdQ==
Date: Fri, 24 Mar 2023 07:52:34 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB94202D9CDD9341554C7FD56792849@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYCPR01MB10428:EE_
x-ms-office365-filtering-correlation-id: a3e58ed6-7e34-4f93-08c2-08db2c3cbac0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +gr8ma/OJcddGqmtcyX1Zzbvb4cA2RR0Uh4tutvdWQGEmuWP0sGex0vrmV9nlF/R9Vrx2R2305WzzL5gDssXC29aEetbE3S+BNyjfpRiTqTSl7Jy7XVx3VA+0RmzzhC4Sx2gtP7ty3/suHbOpKe90OALSPTVmwHaQvo6G4rRxC6ZHKoV147DTbxMMtyBzRZZrplvBwOyROWnYRwiiMg2kE1sj+/tpQ80o1o3qDOm4wRTL3SF/NmWdstLrs6+t7V9NgMklB94IC7zI59Oi3wnQXACw04b3AgQHxKMCuJP4FCIXjJrEDQc6ZX/H3+xgoj0UHfyd6gGNEh3TKvH2qjjGRRgK0UP9YZxUlXItr+B6K5hT2YERw1nCvmxg/vC4BBNOnvoCHrprSDPqV41ajG7MlcQp/ts4GwBV4q5ycSz5MqHN1dT8qC/ZJY5B9fz0OHsl6a2ShiKCjzCzOREKPaJPkPjc2Z5lZiolvftogGvKT1noWmfVlKqw0dOaqQzf85dCLXDzPnDaoXbvisHxZl0IuIJzsFa2XzDWsRVfdlom0gg3hbxRXBkrSagLfjx38uviZZjbS2ec8ydWE6XDNvQzVterjupXXSQE2m/UmCAOEhNc9NQ4q7D0Nspj30ZimNvtVlJqGUHVm0PIRL3cz1psVdbBNCgj/kaZ2UCe93+JLb92OJvJpgeGE+Wszrd69Xd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199018)(8936002)(66446008)(316002)(5660300002)(86362001)(64756008)(66476007)(4326008)(76116006)(66556008)(6916009)(66946007)(8676002)(54906003)(41300700001)(478600001)(52536014)(4744005)(33656002)(966005)(2906002)(71200400001)(38070700005)(7696005)(122000001)(6506007)(26005)(38100700002)(9686003)(186003)(83380400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?R0toT3ZCNXVtVUR3elBwbGdmQUtFQjliYTZsR2pVZEQ5RnJPQXhuVGQr?=
 =?iso-2022-jp?B?OEs1b1lLTFhqeVc5MDlWQ0EvUGo1RDVZSzUvbEFiU2lRT3Q0WUtscUZw?=
 =?iso-2022-jp?B?Z1lzVmU4Uk9kR1dpTnVkd1VIYzZ5MC9ianZobFloU1p6UERpZ1EzREtZ?=
 =?iso-2022-jp?B?anhPMFA4TnFQck5aTGpMVk00bmcxZXA1SkhqNVowaTFLUWZmelR0bU44?=
 =?iso-2022-jp?B?aW01MFRLSmt2dTBZa1pFMiszSGgyc0tWalg3VFV4OTJBVkhPT0t2bG5N?=
 =?iso-2022-jp?B?RU1iZXlJeVZYdC90ekNxWUczd2lYUVY5T3BRYURIbkp5QzdtOTBTN05Q?=
 =?iso-2022-jp?B?VEJ5NUh6dnJoRWJzL055WEl2eE1ValE4YmI0Wit4bGxtZ0RCYlc1OSsz?=
 =?iso-2022-jp?B?ZExWZDgwMTF5SUhSVHYyQ09DdUlyK25LT0YyRFp4VEtSdnNMNHh5WmRp?=
 =?iso-2022-jp?B?dklndUhDbm9vOFg5b1VvR0RLMVNRb050ZmRCa3VzdXd2NE9LVXAwN2M1?=
 =?iso-2022-jp?B?TUhwS2pnVU1jVUE5ak11aS8zcUQ4eFNQbnNMOGRYSmx6dkV6L0dqbVFj?=
 =?iso-2022-jp?B?d25HSzdyNFExbkRHSjlJbUFNbXJrUmRmdDNqQVF2NlEzMHkvczZOWXIw?=
 =?iso-2022-jp?B?U01tWCtZWW9hdDcyM0VLeWRLQlNXOHRQL2pBa210dFdYaEI3NnFVYUhE?=
 =?iso-2022-jp?B?ZGhsMDRQdXMwRHVUVEZTZ0FoVXhLL3VTempVZ1cyZUdJY0srTVJ2eUJW?=
 =?iso-2022-jp?B?YVhvYjRzZ3lmQUhPRkhjbHdqblAvaDRhUUlCdDhYMThHb1BkK1YvTDNN?=
 =?iso-2022-jp?B?Zyt3WmdZQ1IvOC9BUm9XeVZ0V1ZmNFVqR1M3bXVXK2tWcDVUY3Y3SW1l?=
 =?iso-2022-jp?B?WHI4ODIrQnRJZG5IWGZkVDNXaXBQeEJmYlpCb0ZWS2kyZUhiK2xETCtL?=
 =?iso-2022-jp?B?c0hLN01PWjl6dkpEcHhROS9YOGV4dUloTUVvTFJaZDlWYU1uOVdTTGNX?=
 =?iso-2022-jp?B?MHBmVWhnVjhBOTluN21RdGdnY1g3VWxFU0NEOGE1WW84TmE1dVJPNEoy?=
 =?iso-2022-jp?B?ZnhmU095M0J1WlpYYmlsZUZmdlVvU3dJMm4xUk96UkhUNVFSKzN4VXMx?=
 =?iso-2022-jp?B?Z0JQVVpwZVlXV21vdGl6TUVHSGhUdDYwWVpYekRzc3Axd0JDU0lSbXhj?=
 =?iso-2022-jp?B?YzhDRzZHUmtsMGZXMUdjMGFmdG1mTzdISWdWNmpMdjBlcGxGSG9URXpi?=
 =?iso-2022-jp?B?dmxmV1doVjdseXZGMGJwUyszcDZoaEs5Z0VwMWJBM21oK2IxSTEyVVYv?=
 =?iso-2022-jp?B?aHRDcFRqTm81bHBGNjBWOWpKTW9SK204Wjl3bnlrbDN4YUg0aWtDdlFZ?=
 =?iso-2022-jp?B?WmJwbTk4K2h3NW9YanpVMlFuVGhDRDFkNmF3NWxVMVE0MWhBQnlDeEpw?=
 =?iso-2022-jp?B?Y1ZqalY1K2RabENDakZrc2xKcVRnWG1IZzlQVXhERzFHRmJjR0ZZMEZW?=
 =?iso-2022-jp?B?R0FiTkNMZVl0ZWMvR3dqeUFqd1g2VEhBOS9aQVJERUxUcC9PNXg0L1E1?=
 =?iso-2022-jp?B?NE9sRk14cnpFclBUZlFNN2VYRXB4SVVwazdWVXNSWFg4WmxPL1J3Ukdn?=
 =?iso-2022-jp?B?STk0K0h0b3A4aTZ1MkJZd1YvZHRWYUF3WFZQZUd1RWtzWFJyNVBCVzBy?=
 =?iso-2022-jp?B?R0xnK2EraTczelBwMVQ2cy9qMnltZjZGOWZSalhINGdKcXc0VllvREZt?=
 =?iso-2022-jp?B?RzRuQXBmekNTQ2FlL256YzFYcEpydjViZGRvV3B5MitZNndVQWFUVElo?=
 =?iso-2022-jp?B?bytJYmpvaElvTVZXbHUwMFdhSWFrelY2UHF0VUFYenFhY2VUeUU2QnBN?=
 =?iso-2022-jp?B?WFQwalhuY0QxdlQ0MSsxVm9kS3YvNWV2MjVOekZ5bXFZOGNiV0E0cWlC?=
 =?iso-2022-jp?B?ZU52Y2VPMjJiT3lSVnR1VzlwRDBaSVZTU21XanE0elY2aElacnZpcXRz?=
 =?iso-2022-jp?B?bVpvWWpsQ092TTRBVUd0OEdFMUkzV2FPQi9SZmxUMzB1S3ZPYnBFZXFG?=
 =?iso-2022-jp?B?VnE5Z09uNEpuZTlkZ2RrSU1JeWg2Z0VUK2VmMEJYcHZPajlLSDRPK0s4?=
 =?iso-2022-jp?B?cTVTeEtzSnVCbjFyd09OVitPd3M3eHZWaEhyU216ekZwQjgzd1k2a0x1?=
 =?iso-2022-jp?B?NTRiWGZVenZadWVUUnhxeTVYNS9WbEorMXpCQ2I4ekRqanh6SDY2cHVQ?=
 =?iso-2022-jp?B?RzU1MXlFeEFRRkM5MWRiVmppQlRKNlBlanN6L3hvQW1GMmdRNnBZa1lp?=
 =?iso-2022-jp?B?Q3o4MnkydG5SVWRURUxSVE5HTDgvbEJFUVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e58ed6-7e34-4f93-08c2-08db2c3cbac0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 07:52:34.5395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QspGuuaxHH6RR5eSA7pVkYl1U6oHonu0Qm/vNiLbMqQg8etkRsKjuoJTftEW8AWxc9PF6xY0s1uWYDCZfXZfxI0w5BED6SrpQMjLMUu5NiuaV5758kPnXO/qo/9st4kW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10428
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Mar 2023 07:53:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11105

Hi all,

CIP kernel team has released Linux kernel v4.19.279-cip95 and v5.10.176-cip=
30.
The linux-4.19.y-cip tree has been updated base version from v4.19.277 to
v4.19.279, and the linux-5.10.y-cip tree has been updated base version from
v5.10.175 to v5.10.176.

You can get this release via the git tree at:

  v4.19.279-cip95:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      a166e121fe317e5b7a79c09a0ca641ca15cb61cf
    Fixed CVEs:
      None
    added commits:
      CIP: Bump version suffix to -cip95 after merge from stable

  v5.10.176-cip30:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      530cf8a4dace471f6e04e5887f4993ba1fcd3109
    Fixed CVEs:
      None
    added commits:
      CIP: Bump version suffix to -cip30 after merge from stable

Best regards,
   Nobuhiro


