Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5602AC4167B
	for <webhook@archiver.kernel.org>; Thu, 30 Nov 2023 00:05:39 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.58953.1701302731777595365
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Nov 2023 16:05:32 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 3AU05SCv2127629; Thu, 30 Nov 2023 09:05:28 +0900
X-Iguazu-Qid: 2rWg5n14fyLXFWyxo6
X-Iguazu-QSIG: v=2; s=0; t=1701302727; q=2rWg5n14fyLXFWyxo6; m=9aHlfKXHzqFNw3pRSXhu8mz38NWYBTAdprBlp8/fNAA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 3AU05QtB1812408
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 30 Nov 2023 09:05:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKNODy0IiHeW1i15+gRhOZUVUZEA8/2IBrr4hk0q9dcls6Q3NeCmXvASim0guR8RmEOcMbu5CnKDoYZYOuJsUAHITMQFnWpnqrvSvq1kVyM5bk/Bn793wRVrOlG1IfwOeZfVnFcY9gj1stRvzfRJuMS6ia8/A6ahfPmX9tUltWAEtuZuBA3oEISGRQxgN3/P8yXN61e7UD0hUocJZfeRSWfLgRwZc2hD5PbSdu3zY3b9bzRHNCeXEb3NQ6Nx/9CMfm5RjOuZP0wOVVp2YY4NwXn5ULdTJodFU8T2Ihj2jXcQiWqUjQRlaUMhdVDAaUoggDtL5AS4pDqTHhIJ6e3Tbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjtuqkDV73jcELf5cAYFtTqRJsiGrlRHHb6Q8ytN5JY=;
 b=TOWEJpwMewbCbYEIQP61JWGgFfPXowjm0370ujUaj7CyNMJ0nzr/HOx9DsSulCW4L7TyTOjfJ11b9ano83HuvrHj1E+hT+MJHB56v1W4TJTjYh2pXhnMGyY9HD4arl4M54JsLEF+DbW/M4fyggOcHjagq1r3Sn3ZC6xi+t2vSt6p7R71UoqMudhdfTKh8k+ttc9sRCsPDRCRdot1dXc722sq4hvFOiY0ovrV+/1N4VuH/9MRYG862XWNIplPQXiS2U7L1HO1T2qRleDk55lX3SjGKCl55mb4OeMjfGTp9jFb3vxHVGcd3LEbOeUMFZp13ZqKU6HuuUHfzpg+P/e0Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: CIP IRC weekly meeting today on libera.chat
Thread-Topic: CIP IRC weekly meeting today on libera.chat
Thread-Index: AdojIMCACGW8+6s9Sn+/g1KMONtdJQ==
Date: Thu, 30 Nov 2023 00:05:22 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYVPR01MB11245D394C0EABD39E9241E149282A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11245:EE_|TYCPR01MB11898:EE_
x-ms-office365-filtering-correlation-id: 62f64e44-5983-4bb7-a986-08dbf1380c3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 T8+9d7DV6kxxddjTAGQZ2Tn/HUrHKG9Wc3UkEDZ5Z2aRyrlbrDiACfBzHTLvhAHUgv7a4scVczH0ul/ABe5Eh0M5oPAk9PTqhlGxbeZ+g422gaFfh9bQJmu2j3APLlejLINz26T9HVDlNwyiPvr6dXkGE+D8Vj/3kYTEsu/EKOljDv7tQWLXEY+8MOCk6txuBb/yN6OcoqExW6LrIOiOtcSgu5N8fpD3Kkr5mxRYnd4ULESU1k1JVdwrfMxCQoLFwhYVVMUISZzhpvEsKlSXzpHug/GCoT/1Gk488/2yp7ZL+1j3kiB4mrIKHu3/4MGq4mGS+Y8UWlgr9erWVH5N9sNY98/9vHEbo0DEoqnDwm6g1No8m9oAbWE5Vpqml0SLrk6BN65I26BwXZDbp0p7l1eOpc+nuGEidiccluL69C76bZXVb2ELMq9SK4iLX62TseF2GAkrUV14aciATqlGsdbSR2pg5kpEGW7+/4qV2gHHrSZ9xRH/U2xa4qbdTvwvJX6shvGSGYwyuMGxiZPj5GQwP2OYIzKqK6QljCMbwbp3LkkPXo9praoHNlDSe2SNwDjMEqSYcsMTr1uq1AgruTXQXNndV2QtthtY/MzWxHWrsFJjLJwrq9Din8nGT1iPNYaB77poG4012c22W8qKkob22wKrPbIRLv0OiZslgdnTFpoo3CvhD8NC911UUUT+
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11245.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(396003)(366004)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(71200400001)(9686003)(478600001)(26005)(7696005)(4744005)(5660300002)(83380400001)(52536014)(6916009)(41300700001)(6506007)(76116006)(966005)(2906002)(8676002)(8936002)(66946007)(66446008)(66476007)(66556008)(316002)(64756008)(122000001)(86362001)(38100700002)(38070700009)(33656002)(202311291699003)(55016003)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?K2sxd2VGQXNaUm9oNXRiVlNVY25GQSt4WDFoVTIvcGxFWGMza2J1SVZ5?=
 =?iso-2022-jp?B?RmF5ckoxekdXaEh4eWsxRlJiZ3liZHl0dWx1TStMMk0xU3lWU1RjQTJV?=
 =?iso-2022-jp?B?Y2I0ZTlVeE5TV0pTOGVPNHFYVzNPZ21Vem80c1ZaZFBKU0FiaWplaUVY?=
 =?iso-2022-jp?B?dDRPQjM0WkFYNytuak0zZ1pvaG5Sb3YvbzdzQ0piUHQ1SVJoVUhwYUJX?=
 =?iso-2022-jp?B?aEV2bTBzN3pzMzNwdzBYT1pyZDdyVUFkTTFETFhGUDRTNXBjZjkyV2Fn?=
 =?iso-2022-jp?B?R0VubzMvdDFNRDFpZGtaQWpLODMreDcwNjMrSTIvUDJIYWdDQzVmRXYv?=
 =?iso-2022-jp?B?U2hGdG5HS1FmS2xGVnVGeTgvcnpQSExGYVlXbEtDTnp3dEVKMjlyOGZI?=
 =?iso-2022-jp?B?V2xyN1N5MkIwSWJiOVloangrT0ZuZm83QXR0T2ZlcE5xaWlpNm54K1l4?=
 =?iso-2022-jp?B?dkxyOHBMMGpYNTdaN0dLdGc1V0tCTW1PckxNNklJeW5XU3k0LytpckYx?=
 =?iso-2022-jp?B?b0lsWU9VV0hwdjMrMjErQUhPemVlRTdnWFh5NWgrdFJLSWhGM2xpVkhV?=
 =?iso-2022-jp?B?VEYxSlAwUHo2czNxY0MrTFk5V3lEVmNabXY3V2o0Q05TbllQMUppbnhs?=
 =?iso-2022-jp?B?ckxQQzd1OGJlbkcyb1dDUi9Jck9JTi9NYXhwL3VIcHlJVTdwY0RjV1Ev?=
 =?iso-2022-jp?B?N2tpd3E0U3dLMUpCKzRNdG1rTmk4cjltaE9nR0d5dG1Lb1VUSGovenRv?=
 =?iso-2022-jp?B?cWVYMXQ2QmNpcmljU21Ma3ErSWNIODkrVzVpMFllOHMvdDQ3NlZ5YzRL?=
 =?iso-2022-jp?B?aGEva1pTVzI4VlhValZNekRiMjlUck1FZVMvZnV1aWlGSE5GNmtHMXU1?=
 =?iso-2022-jp?B?dFU0eSt3YVdWbkcyYXhlQWdJN1N0SVFsZmE3cTB5eFYxMjBjenRvNTNC?=
 =?iso-2022-jp?B?WURCOURUK2E0TlNMRHVaOEprWUthbE0yVVVmUnFrdC9RL29CYit6anVV?=
 =?iso-2022-jp?B?YVdpcmtZUW1EMkpMeVhEUmdra3V5RDFGdVE5YTlVVXlneTM2MjhhZWVZ?=
 =?iso-2022-jp?B?U3I4RkJIZkZ2RHlKMTRyMGFqRFVHd2VuNEhYLzVsSDNQTCt1Qi9idTVr?=
 =?iso-2022-jp?B?NTdHOG1DNkM5cGJJeDZVYzdVYjZvSzEwanErOThuMWFET0k5L3VkWENH?=
 =?iso-2022-jp?B?VUdnNG9CK01nbnJvTGw5YVFiSXppUkExRThGOUppa04yRWZ4UTFqNUtQ?=
 =?iso-2022-jp?B?K2dmdzRVYnpnS05EaDJZMXhwSzRhcXd2aVlsbU9sSGNxR0ZtSHlPcENS?=
 =?iso-2022-jp?B?OVNISFQybkgxYmJFWDBsbDgycFBwSWdWdEJzOE9hQ1ZqaFljZjJmdUNY?=
 =?iso-2022-jp?B?NXNkU1hJWGluMkozTmtWU3d2ZHFvTFdpVnVwZmxDNWtrTWVwaGF2UXNj?=
 =?iso-2022-jp?B?U0tZYXg4OVRFS05UaWNyVmM0dlR2ejRkeHI5eDZjeWFPQUl2UEprdjlW?=
 =?iso-2022-jp?B?dVpZNVZYcXFBaUVpSWFYcVJpdXZKYVNtaXBKQ1FFMFVoY1JSWnA1Ky91?=
 =?iso-2022-jp?B?TCtZQ2FxS2lZblo3S3ZHR09GcFp4ZmU1bFFTOEYvMU93WmJvLy9RSmtx?=
 =?iso-2022-jp?B?UWlRRUxuN0k5SUFNbHZNUTFSMGl4Zk1JaUdqbnV5bWlLdTVpOGRoaGxP?=
 =?iso-2022-jp?B?aXBvQUdNUG0xMFRnaS9McGVmL2t1QXRhL0tDYkNNUVIwcGtXMkZNOFVj?=
 =?iso-2022-jp?B?MXYzRDc5cmViWnNQVktieldGdEFKMWlNNi9ZdHI1RzFxZDdDWVJ1TElK?=
 =?iso-2022-jp?B?S0RhM1lZYU5LRElkZGU1RmdGVTd3YythY21Ud2Vha0FCYkxHMzBadVZ3?=
 =?iso-2022-jp?B?U00xcnRIQnkvSHFvMnU0QVFtc0s1bHZUVzc2eWp5ZjFoVEJ5SmJjWktD?=
 =?iso-2022-jp?B?M0VnU28vQU5SbHNjMmpzSDR2MjdIRDFYOVVTZDdWeXVwQi9ESUdkdk9L?=
 =?iso-2022-jp?B?RXBpQlFBbjgxTlFtcGpUTnlWNEJIQ004TnVBN1BsdUlXdVBYeE0weTNv?=
 =?iso-2022-jp?B?MzhsTGtsTy9ydXB4ZUI2THdOdXpBZ1loZG9ZbGw2R3YzQ1dtcnZNaWVl?=
 =?iso-2022-jp?B?bVB5ZjRYdFN2RzFxT1g2c3l2L3lSbzZ1RDdlQ01YcElXRmFxUUJHTDFT?=
 =?iso-2022-jp?B?K1FDV0pTcjhGNmlNYjhTM3N2a21WZ1Bha2lIS0xCdExVOFc4YU5wWFVq?=
 =?iso-2022-jp?B?V1luTzFSZW9CRldla1dGT2UxSGR3OC9yZXNER1V0T2dIZkNxMGluNHY5?=
 =?iso-2022-jp?B?RWROUDhDK2NjWTVXdHIwS3BEb3RCajRuMWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11245.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f64e44-5983-4bb7-a986-08dbf1380c3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 00:05:22.8205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4tfCTq+szBCftBRQqsBC4QavnvTKyUCEq7AB5MbaJm/DYUBeq+unvDc7P+n3witvv/znkHoU2qCBhtM/4+J43yMbbsoTUZQ9W3pIs6nM9kV+XwhvyYNk38qcQF2ugnVO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11898
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Nov 2023 00:05:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13763

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2023&mont=
h=3D11&day=3D16&hour=3D13&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D3=
7&p5=3D241&p6=3D248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/11/cip.2023-11-09-1=
3.02.log.html
* Action items
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
  - 6.1
* Kernel testing
* AOB

Best regards,
  Nobuhiro


