Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B580C4332F
	for <webhook@archiver.kernel.org>; Thu, 22 Dec 2022 12:11:11 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web11.44162.1671711065518572280
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Dec 2022 04:11:06 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.154, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 2BMCB3ge023613; Thu, 22 Dec 2022 21:11:03 +0900
X-Iguazu-Qid: 34tKr4VoALgDOL7Pwv
X-Iguazu-QSIG: v=2; s=0; t=1671711063; q=34tKr4VoALgDOL7Pwv; m=1RPr7kgw7OTnFIBRp0jVsE2eVr5fOX9m80y9P1bQKCI=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1512) id 2BMCB2YH016271
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 22 Dec 2022 21:11:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdqIA5mBf0zk8WeWUJZ1sWHZ9jCi0Q5mJaLGviH/r9m/c26DRj3vpVG7nEXGiNxNexPiUBvoMdZ7Xviyhx0+5c9GjGalg3i8ca3VAuSVrywCKrQ2iI6Cu8rzCsrg7Kc/WtAALC4OUbRcevpo6zwtA5Y1Qcgs7lmu1aBQ8Lh7HqHfqeeRsU2K56hDhKHDsq08ZnaWc9PyhwuF19deLCfKMm6uR0bs2DCXzdZhG7Xu0xvUWqyxxmgQC31cnQ8Y5auDllmYkuECw6EUETqItl66Hi2ZVz2cdK59QsWJaT1fUUNdP9/7wiwDvPpMzkbg+0kMSPeHeQ8/YEJmfPbYen7smA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GcYJeE7g6KxZ/s4rHPi3e0DXjOyYJeivtLLMnd9Zfg=;
 b=dMy9Svx4fyOSKNonjch51IAfi2TvOSBaeNu59wjMxY8k73kI+l5dRni8WQTUUtPBC20PLDYcvFnDrwWrFq2NvU1L45yn8AjQHkmott07UxF4BnoLIzeajAAJd/+enB6S4U4zydp7sB0cl+6olWf58YyPcHnmQIfgzTAmt8J/kBazrzMvx1axS+sA3tWESLrSXhhdAZyvxvwmU9jtYen9h7XMtgulPTSSBxLXZ8O2a0uzu16ctA21iczfsq1Pp8izj4ReMQoKjUGQsqOiI2n8/EskgIV2ikQaiGojAx0ikzQOY0cXlnAluaJlHm8OuS5OFigFLXUn+3N3rzhDDQZoRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: CIP IRC weekly meeting today on libera.chat
Thread-Topic: CIP IRC weekly meeting today on libera.chat
Thread-Index: AdkV/gs2mlqE2bVKS+O5HRiOyZBKUg==
Date: Thu, 22 Dec 2022 12:11:00 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB9420F4A2D9CB315449FA582192E89@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYYPR01MB7880:EE_
x-ms-office365-filtering-correlation-id: e65f1111-cb52-4e07-03b1-08dae4159706
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jlsKwmTuqiVKybX40n5DA35Amq+D/nBUHqZuw06aZopsDHGJmfPrAwEmuzz91K2i0Qpj5Qva8SB/CExPSUohGlOD1UkD+nLwtTI1oJKe3AwZty/eWhh26wxjLtt5Vno8mZf7hz3ATgfOqpp7iN5qpnYyUBDD6CetTDPoJUZ1Py0v4s1Gir8xn1op90rwFsCUzwpcW1nPr/B3miPYQzE7/Q6tegoli2hkP0YLf0Oyi/eMaYJ+0e0ME5xbUKJXLurzAkEjTShPGddAcfgCxg6T2OHI4eLyHpo5oHXW7j3wejxRCkbqCRL5j6g6MK93QUXePynqqClq5rF8pwxgXl28OdktagKaRqiv/GmQwQ72roFKqP9i3zrIONUDBuJ+pkr6aI0KyGCuGrLI96NytNdh1uDjFEjUuGr591f2m8HVm3z1ESdKPMvoQN+Zf3E/rFfJV6mwMCRFzmrWdULsGrP6ZZ66M4LoPqLlL42DgTK9z4jHacL1sCAG5D82cdTGPFT0kgLOvuwn/lwOvSm5Cm6mmiMf24hasYF7BrWtl+Q0ozF31SoRwYd0bLr9ZSuCOJJCZAorEnhM7+mf2Mus9AXa03koWfbd4X9cV+h4prYD3g5B8/E3y4hy/UVvCZxxg2gKH5lQ7jwZEqYmrTaaoMTWGiJXxWfEHPb7ywdLS/ZdZJfhpLRWowaY437SW+bv3/834JjN19RhUEM3aEzVP+Xh8hLcb5t3tFJtALk4Ewcwn18=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199015)(76116006)(41300700001)(66946007)(4744005)(5660300002)(8676002)(66446008)(33656002)(64756008)(66556008)(9686003)(66476007)(8936002)(52536014)(38070700005)(6916009)(966005)(2906002)(71200400001)(478600001)(4001150100001)(316002)(55016003)(86362001)(186003)(7696005)(6506007)(26005)(83380400001)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?QU1BZXJMTVJONnFGcGJzeVdsczY1LytJQ2NlSTh2QkJ1WjI3ejhkaWZ1?=
 =?iso-2022-jp?B?bm45TGdCZUkwYzBzZ2NMZ2RPM1lxQ3p4K01GeDEvY0p0M2xyeFVQVkE4?=
 =?iso-2022-jp?B?U0lxak96cXpZcW00MW5YWmpGOUVBN2E3dTllWDNDcXYxSFp0Mm44YVRG?=
 =?iso-2022-jp?B?RitSbHpvQytKK09UM3E2cmNTRDZqZEtFVDlSRXEvcmExTFRlYk9BL1V4?=
 =?iso-2022-jp?B?UWVkZFJYemFnQ3A0NnhWVy95a0w4VmRPOWd5SllRSDlLSkVtU0RjazQy?=
 =?iso-2022-jp?B?SE5yUHJGVnFqS1Z4RU5PQ1VYc3NOQ1JuWVNndnZOd1JSbk8wQlBEeWV2?=
 =?iso-2022-jp?B?a09id2VyODA4RTZoRTdpNDJQYmlnNFlhdHZ1NnM1MjR3Qm9nOXR5VDhC?=
 =?iso-2022-jp?B?UlA2bXFBbXJvQm4yMUM1T204YmVqVE5scjRiRUt0czYyTXNFSk1OaHRo?=
 =?iso-2022-jp?B?QnhZT0htQ0pSU3VmazMybkZvYjQyZmlwN0JQTXVjWmlUcjJLdUdibloy?=
 =?iso-2022-jp?B?YkVON2dxckFGRlNGN3ZaU2ZSUDFoYnZLbFNjRzZacmdRTU1OaHQwNFJG?=
 =?iso-2022-jp?B?SVIzd1lRUU5KclFTSmNBaFdzQjIwK085emZsZDB4dGw4ajEwRStKM0pj?=
 =?iso-2022-jp?B?c0lmMmNBNUJxYUpwSEhGN25aaTRoRnRPMHZaQURqYXhleWhDalRGK1JM?=
 =?iso-2022-jp?B?NjNEUXM4RXNwRVlpR29tMGRFR1FHZ05xVFJ6NGVFNFJqQVpqVmZCK3p4?=
 =?iso-2022-jp?B?ckV4YkxGc0phdHVQcUlEK3V5WXBEVG52SmhKdUFzQmtTZE1HRDJnQTJ2?=
 =?iso-2022-jp?B?UnM4dGZjMVVBaGErbTNiYURWWVBzMGRZOEtJZlpJZWYwSWRiVEV4WGVH?=
 =?iso-2022-jp?B?a2krcG1wVytrRHpGNzVsNGsrcnRpWXgxYjdBWXlCaGcyUDFUemZVWFk0?=
 =?iso-2022-jp?B?eDVnUzRrOTJ4cS92Y1J1NFlvd3NadzlXb2FtdDVCZzB0dlo1elBEbnow?=
 =?iso-2022-jp?B?a0xQMkEyTUdVSHlWSFB5N0tBNWl3TXJROUNLeDl1Q2h2SEJhOC9pWGQv?=
 =?iso-2022-jp?B?QlBrclJUaEpyMTRhSXI5b29IVDM0VVdlZUt4QmVWMmxpU0RmNUZlbFdS?=
 =?iso-2022-jp?B?dlJVdzRzNW9NZFVhWEZqbXRYdHRnTGl4SU1YY2sxdHNLT2RJZm0rUHB1?=
 =?iso-2022-jp?B?aG9LUHBESHFZb0FYaVNudkRKM0g3RGpCd2NmUXlSMkI5SnZnZnZVUm1n?=
 =?iso-2022-jp?B?c0FUd3JwZmlGSTB0ZE1OVERuaTVYbnVDSmdjNkFSak9oT1N2MnUrQXI0?=
 =?iso-2022-jp?B?RzFubjFwcHh6QTdMRW9uMDk0Qk5LOHdWTk5MdEZjQ1NFKzNGelFaWC9n?=
 =?iso-2022-jp?B?R3dNTDZJRWFFaFpjMlF5SmdOV21MOGs3Y00rdzgwZU5ZWis4WTRNWFEz?=
 =?iso-2022-jp?B?b3l4SVFmMHVHVFZPanB5VUhqUW5NWGZndXk4N2orYk1wL0hBMHRQRnY3?=
 =?iso-2022-jp?B?THhNTTY3Y2ZTYTE2UDRJUVFkWTNRY2E2VklJMy9vR1dPZWxZVHRxTnc2?=
 =?iso-2022-jp?B?TFpSdXJVNTNRSVFDc1RrRXoxdkJTdVA0S3FUS0ZKZVhpeGRNK041T2V4?=
 =?iso-2022-jp?B?VHduVkNtY2N2NHVUY2pnVTBvNmRXM1RiVzBTdjV2UnpYZzZ6MTdqS2Rt?=
 =?iso-2022-jp?B?SkZ0NWozNTd3VmZhd2RLVys5ZWFPb0QyVzZNaGxIZGlEMXQyb09ESHgy?=
 =?iso-2022-jp?B?RzFaV0J6bytBd0c0M1hxejhWd2xUaUZEb3RCTURSMHU2Ly9jK1hPY3Fj?=
 =?iso-2022-jp?B?RGoweDhVZ0tsQURUQmFhd1cxNEFjMXQ5WVBtN0docW9xN016SVIyVnN0?=
 =?iso-2022-jp?B?cHg4b0dXUHByQnJTZXRxZTFRS0tMRFkrb3JtNTZCQ2RVaUE5UW9WNXZh?=
 =?iso-2022-jp?B?MTFaYVl1WWIwT1pWQ0dVeS8rbi9zK0VHREFZVHZIYUQ0Y1FVRmZ0bE9Y?=
 =?iso-2022-jp?B?T2l0cWQ2UDdObERQRDJMcGlySGNJRStJb085SG15anI3L1duVi8zMEUz?=
 =?iso-2022-jp?B?eitINHE5RXNtdmtjR1FvUFgxbHVZOE9sRzh6aEVxUzRsdnZkbHEwZW4r?=
 =?iso-2022-jp?B?elFwcUMzdlpNQStYY1dTZmc0dU1Wdm1zeVp6ZlYzSnozR3g4aGlNSTls?=
 =?iso-2022-jp?B?MnQyWkFwMU5JbVo3M0pYVlhrbUFDWnVaTXhQeVJ3UXZPTUZlcVdNeUFj?=
 =?iso-2022-jp?B?NlFpMzNBVndQQWZmSHpKbHBmTXRKMGVHNGR3aUJaMVVIVjdkZ2UrbXc0?=
 =?iso-2022-jp?B?R3ZHQ0IrZm9idzYyWVFLOUtubFlmU0ZGR0E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e65f1111-cb52-4e07-03b1-08dae4159706
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2022 12:11:00.5077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4xfyytDy+ClKwDxT6yLCQbwoaX6A8fNDsYfFpFKpGjf4gghHCNxPVQh94VE5RzfnctyrYlp/dw25sr5kSl2NrThl8D3Uc5HUmABuOqQAo824Zg9lMyzI8vPsHO2a++yr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7880
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Dec 2022 12:11:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10263

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/converter.html?iso=3D20221222T130000=
&p1=3D224&p2=3D179&p3=3D136&p4=3D37&p5=3D241&p6=3D248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/12/cip.2022-12-15-1=
2.02.log.html

* Action items
  1. Add qemu-riscv to cip-kernel-config - patersonc
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
* Kernel testing
* AOB

Best regards,
  Nobuhiro


