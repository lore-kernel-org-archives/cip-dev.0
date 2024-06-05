Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6570EC25B76
	for <webhook@archiver.kernel.org>; Wed,  5 Jun 2024 23:43:37 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.1334.1717631012639942710
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Jun 2024 16:43:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=NAd9lKUj;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=1717630990;x=1718840590;bh=/F
	YQcpIPKdNDt1ArJ18o5FPnXYCOVHwf2yalPoBZwz4=;b=NAd9lKUjvDgDUDxlRxQBdUwTyD0pDPcv
	tEBlkxpikToayw3wItfiWMjMj0CR26y/duJzSc28OTYNSaSeQf/0Iy0/MzpcSnuXP0x2Sz/S5FcQi
	0/nA7V2FEGWAwPPB+2xY8VAiSI8VQ8dgKmvsS3c05NzdVQ6T55anI+6J0SEh1a2+bouWx19D+6k6W
	j4lpgvWILD/3rO5rYPJFMiqd3n114sHGpua6amiuvhJcaN9WS37N+dHY4HW4YQHnMGGa81KlsgVBu
	GL/4smSvGEsoEg/Oxmdq1wMkYStuXd6HXQ8DlmYG52RdUKnD81/m9+pI3l7ga2qOWd9Awk7+ZaciS
	QQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 455NhAM51291881; Thu, 6 Jun 2024 08:43:10 +0900
X-Iguazu-Qid: 2yAblVO8Ez5seRRAbB
X-Iguazu-QSIG: v=2; s=0; t=1717630989; q=2yAblVO8Ez5seRRAbB; m=FXF4sOAku3iSMGdwqm0On+2TNNX1KQ9uWFpwjvDqSnc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 455Nh7eh2514707
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 6 Jun 2024 08:43:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BB74nFrvpvfMhYm4Dfie0yMadVcd+ghMu/fJDgfbJ6qdDM6WS5ZcEvzjcGm++2vqXO4px9D0BKH5JJVOyvx43rovn6C+q+xVVHgzyUsLoah8/4oej0qS/ldtnARl0ivIGMj+MGnijpld3Q0BVdhk4FdsmupENI9IwwRghGQMqUxD1F+tyoeCdjoXnaQXVtKpbN+DI4PYHP0mD9I9Qjlw+4Y8C88bSpY2QBxpsp0MXKynTV6zfGcNdkhLy92o2laLQU81PFaTkJ5eqAl1+R/TLdg8m6fhol1wW1wgZNJOY0w7J4VJy1pZxjD8RTxaf3Q2IqfGfdGcyHAcKsV08O7Y1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlRnxDKcGkl9ur2oIi5Yk7Hqvy8zmY1Fp9MDUxDh2os=;
 b=WrIhwSpVdTspjduheymBo/AvmqfhliGh0mum+vJTmlrXXqXA0DL95qZV8G5Pg8QfbJlm6kFVz3zLxQEmvra2MMHPMPBKPyCGYSwdBgoaa6VotI0jY1Muh2i0gxlnvXiO5RZYVyoav/8/CjvGR1fPD8U0dgDZLyF4bqhqCSu/sfkftCxSWoS34b5b3MEJLdOZObxAfUHSJ3x/1QdO1Z92+4GRP3z81SVFiRn+cdxS6lacjEwmrMUE8qsXGQbpmiQsxykvSc/JNRpZKnkM+mvsX6CBAtFEVw4x2ulQYqNWLG5uVNoqdrMwgc0M7zznPPpsixeyrGJTM9YDd6TkE972HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>,
        <masami.ichikawa@cybertrust.co.jp>, <uli@fpond.eu>,
        <Chris.Paterson2@renesas.com>
Subject: [ANNOUNCE] Release v5.10.218-cip49
Thread-Topic: [ANNOUNCE] Release v5.10.218-cip49
Thread-Index: Adq3oeuTxySPn94ERCK6RUyr+wwm1A==
Date: Wed, 5 Jun 2024 23:43:03 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388AA53B410AEABEED3BC1A92F92@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OSZPR01MB8497:EE_
x-ms-office365-filtering-correlation-id: 7472f8fc-f2cc-4638-b1b7-08dc85b93e2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|1800799015|376005|366007|38070700009|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?Zjl0SlFsT2pmRjYrcHhGb0hMUlhNUjBjSmVVSjNhMXVpZURTYWFmUy8v?=
 =?iso-2022-jp?B?MXkzb0tFT21RUkJxV2RHY0dONzh6dW8rbGkvSDBJekVQTDhzbEwxL0k3?=
 =?iso-2022-jp?B?M0JOUHN1L2lIcEsyZ1NSbDdBYTRHZ3M5N21haHZMbVhjd21PTVJZMk9K?=
 =?iso-2022-jp?B?SU8rcVJJMDFQdE1lLy9haFpRcHUrYVdnbHoyY3R3dlc1dDlwSWE4Z2gz?=
 =?iso-2022-jp?B?WVlGc0pkcUhyRWdNV2QrK3IySWJqWDR0Rmh4VUZPakdvb2JnTU5XOWxj?=
 =?iso-2022-jp?B?c1oxdXZneXluU0RNMGprazlnblpRclZRdDBSZGc1NFc3U3RDVTZzRWFj?=
 =?iso-2022-jp?B?aFFBWFY2cG9lUTNmeC80WW56OWgzM0w4TFdUQXVjKzdFcHZtMmlkSkF3?=
 =?iso-2022-jp?B?cUhSeTVWbEcwVldESmVrYVA2dm94cWZhdHQxc01HQWt0dWVIb0ZJMUl0?=
 =?iso-2022-jp?B?TjMzaDhjZDA1M1BxcWlDaWxTUWxEYzNKZ3k1S2Z2cHhEYnFacjFZeXF4?=
 =?iso-2022-jp?B?dStaNUgwOWRUaHIzdEkvNW5qTGRtT0RHUVpVK1p5ZXRxVUk5K3greVVC?=
 =?iso-2022-jp?B?Z3h3RE9BSFRSUkszQlY2Z2JzWXE0eUtZaVF5WmprdVBPb2d4cExIVGsz?=
 =?iso-2022-jp?B?YXF5MTVJbU9IV1VSbWFBTmkvaE9lQlh3NFl4VldQK0hrdU9vZWhnQVRK?=
 =?iso-2022-jp?B?blhZZXFNWUFzTzRKeUlVdmZYamJRRHRnYjBpM05kemxNbUxIQ1NSbnNy?=
 =?iso-2022-jp?B?eTF3WklmTlVHckwzZzJaKy9ONmg1bU8vUzdFbmhvcEVjTERYeUdLeEhQ?=
 =?iso-2022-jp?B?bUpFSjY0WVVuWWI3Z2MrR1FjclJaR2dvTEpPQmdodzE2RUliL012R0dM?=
 =?iso-2022-jp?B?akhadHZsY0Z6N3p6TkhCeGI5c0JZYTBvODNUYTJ5ZCt3Wjg5b0J1VUVN?=
 =?iso-2022-jp?B?VHJtbHJiREZKVjZWcE13ZGZjMzRyazVjdTZxL1k3WHZVb1JOQUZXNzVV?=
 =?iso-2022-jp?B?TlNIRmU4TzFjZldHbnp2bDdTY2o3NGVhZDBkQ2ZDaHNDN2pqYUNKcnhy?=
 =?iso-2022-jp?B?T2ZxeGJqRklTNnI2QUo3WHpBMllNSTBLRWJmL1IzNWIvem1xOVA0QmlC?=
 =?iso-2022-jp?B?aFhoNThsSlBwSUtXRGFYV2lWaVU1c1VmY2FSdWZpcEM4K2oxSVcxTkVl?=
 =?iso-2022-jp?B?YzQ3VjhLenp3UWh4Y3dRZC9vUU16MnV2aGdOT0xMbzBMbmNsTUV3MVhV?=
 =?iso-2022-jp?B?OEo4bWRzNS8vUHRBM1ZhVzRxR3IvVlFGdmZLTndxazRydHQyaFB4OU5B?=
 =?iso-2022-jp?B?cEZ1Tm5UYkpVM0l5am5vaEZ0WUtGbXg2ckRxRnlKczBEN2hxUGVFQWRv?=
 =?iso-2022-jp?B?MWtoRTRLT2RiUzU0a0pXcHZsc1hqYTQ2MjdVYzlaclpwTDY5M0NMTGd6?=
 =?iso-2022-jp?B?QW0ybTNaQ1dXU2xjWEdmTXlseERLT0E2bzJEcG1FS1J4d3A4Ylh4YzZQ?=
 =?iso-2022-jp?B?UHlRN0RoV3ozNFhtQ0pybU9TbTV3SVJkcTBGN3BXVE1CRWU1VFQybWpQ?=
 =?iso-2022-jp?B?UjIvZmFYMzFldms4WmdzaWhwblJMbk56YzFPQjZVaHJxZ09IcjJubnJo?=
 =?iso-2022-jp?B?K1BLNUsxczhrMGNXcXlNNEZrWVlXeVVURzFCd2d3U01DdzM4R0xVZW9r?=
 =?iso-2022-jp?B?WXlHZERtSGVJeGVKcFJyOHJ5WVF6eEZRRkIzNXVJY290R0V2Q2VHd0x4?=
 =?iso-2022-jp?B?by9ZbkNkdVhuQ2FldWlmdmhMejdySWN2RFA3OFVOUnBLZ0w0UEo1cXhT?=
 =?iso-2022-jp?B?OEs1eWlvOFZNNyttRGtsRm1pU09DcVludFBQZUY0dGx5REo4b0ZRMTJW?=
 =?iso-2022-jp?B?OGRTRU5FRzJ5UmdsVHVLK0E4aHhTSTVQWXJIbjRldzdJTU1hVHB1UDdh?=
 =?iso-2022-jp?B?TDNJQVBPQlp5RWFLZnJEM3lEUXd2S1ZIcE1uZXFJbWs1OEFucXFEQWlK?=
 =?iso-2022-jp?B?dmVMUmQrOWRTc2JMakNlOHFsVExPQkF6aWVMK3l3NkcwbjJlUi9XaVpZ?=
 =?iso-2022-jp?B?ZXc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?QUJzdlhGQ2xMLzQ5TVJhNlBIYVphZHVzV0xIczNidkhBclZiUFk3cE9u?=
 =?iso-2022-jp?B?Mk9sajJFeEhlSEJTcFFnZmRpM09jV3krbm14TEh0dkJPU244NWY0b3pI?=
 =?iso-2022-jp?B?ak5iL29GK0swMldlcmZxU1pRVmpsc2wvbmFBMEFFUjJ5SmZoSGlBYXNt?=
 =?iso-2022-jp?B?N1UxZGtSRnowZUZBd3RPa01IOUJJSTNuMDE5eGVHSHVJQjhFbHZSbWkr?=
 =?iso-2022-jp?B?YlU1bUZ4SEpQOFdCM3Joa3ZScjhYSmJ1V3FHQnRNRkt6R0dzSkdZcjcz?=
 =?iso-2022-jp?B?dDZxL1BBSlBIY1greW4rei9wOUlKbThEai9wK3NyOUpKTXE5VGoxeVo0?=
 =?iso-2022-jp?B?enFGZ2ZRQ3BNVlp0MUVIUFpWU2JBREtEMFRMOG41bHluYkt0SWZFZ24v?=
 =?iso-2022-jp?B?SGd5L014TjZVUHBBb3dWSkNPTVdqcTFmbW9tT1N3V3RXbzRzamp1UU1x?=
 =?iso-2022-jp?B?dkpGTENrRVpUZWVZM1FIVUlUNDlKUGtCNHJDa3FRRk1sRmdlQkFqclZV?=
 =?iso-2022-jp?B?Z1BKVkQ5dlpvQUE3MVkwb2xIUndnT3ZDd2lmSXZ0NGZBUWdWaG9xUUNX?=
 =?iso-2022-jp?B?ejc5aEU4TG5qOXlmU2pxd2NPVFVvT0RyQk9PckJjUCsyUlNlWWk2WWU1?=
 =?iso-2022-jp?B?Qm1HNjhqbnBYSmhEYlIyM2tIZk1rVVFwaUlxWjByZEYwem1McFRkejBi?=
 =?iso-2022-jp?B?Yzk2WllZUnk3MVFXaFYvTUZ6TzFCcU5Rd1BySXFvaXYxRmllQ0dPVlNk?=
 =?iso-2022-jp?B?Zk5sYVVIM1lVUDJjdVphclorRmpQSFFtOWpnSkErK1Vad1FuK2FsYXZz?=
 =?iso-2022-jp?B?R3M0WjdhWHBWRXpPTEcycWw4WmcxdWRHSVRnRUF2TjV1R0FudURJNGZO?=
 =?iso-2022-jp?B?SkZpNU9pb1VLS2tOcW5sNFRiSGQ4VmxEc0VtZzZhV09iYUNDS2pvZURw?=
 =?iso-2022-jp?B?dXdleldRMk1aTnAwcVprSStPQ1VWMzdkSk1uWWhzbDBwOEpWZmc4cUM1?=
 =?iso-2022-jp?B?cGQ4MzdoRGNUMGlFSHV1T1VrMGlmT2kvM0hRSEo5S0dSSjMyWXFVbm5B?=
 =?iso-2022-jp?B?dzQyRUpuOGFKYmtja1lISFNia3JPOENRQzlndll4V0YzTEJCK0hNbVRZ?=
 =?iso-2022-jp?B?V1BaNCs1K3NMMmZ4VWlWVU5kREY3V0hLZnZOck5Id21Ma096L0lHUjRa?=
 =?iso-2022-jp?B?b21IYjBEVkx2KzZpamk4OG1hYzZuZ0hvUFk1L3BlbUp4YXVjRnZzYWtz?=
 =?iso-2022-jp?B?d1M5OFExZ0dCNjBYZVhNa1ZFRk1mTERiWnNPK0V5bndGR2pzUDNtbE9V?=
 =?iso-2022-jp?B?NFBTNXQ1cWJoNWtManIxYkk0Q2grSzRPc2F0V2dVWXJ3empxYUVwNE9Z?=
 =?iso-2022-jp?B?SG5hTzhsaTFuazNRdDJqQ2JWckp0R1lINDFOYXNuMUd3V25XYTB1QUJv?=
 =?iso-2022-jp?B?KzRzRjVLb1dER0N5ZkFLM1U3VEpGUmFwdEgxbTBPbjIzd25EZ0sxQy9C?=
 =?iso-2022-jp?B?bG14akMyellKVFBOZjVVS21McU01aUhOL1RmMFJTZlZ4d3Vuem4rWFBa?=
 =?iso-2022-jp?B?cmQrQzQ5bHdXVll0dFdTV2NHMFVsMmU5ZFN0cFVwYy9lZkhRLzZIQUtY?=
 =?iso-2022-jp?B?aG9iUTF4ZlFhcFJuekt1UzFnWHpTTzAxbXZreEFYdTl0RTRuK0NCdjZF?=
 =?iso-2022-jp?B?Vy9yVXFHcTlHZjBoV3NQSGpaYWNOSjJZZWI0ZEZqdERsTUprMmpXUWdY?=
 =?iso-2022-jp?B?L0pTN29jcnQ4U09yck5abGVzTjg2Vmw0bFFRNFFwMmxaODkxMVBYUE4v?=
 =?iso-2022-jp?B?WjhZcFFCbHR6MU1RaExldTBJaWdsUEVxcHd6N3k5SDhPVnhVTHZ4U003?=
 =?iso-2022-jp?B?RXl1UVZRMmdrekdQNGtNV2kyQkFOMHVOeVpaKzNMZnVzaENwRGo4bjQ5?=
 =?iso-2022-jp?B?bGRLQjFsbFVkbWkxNldpT2ZtV0R0RDI1RmlwRmJGNkYrNktsQVBPUlMr?=
 =?iso-2022-jp?B?T2FYV2FEM2J3WDF5MEZ4K08wbzhaNWU0dlZDWWp5V0IxSTRoUVQ3dlN5?=
 =?iso-2022-jp?B?Qm5PT0VRQWJvUFB3aFNDTVpSOG1uSGJLYWRXcXBSb0ZHbDhHWXBTNkJW?=
 =?iso-2022-jp?B?UGw5cHpGS2VFTVlwOWgwSnpRZjRIcVBINk5FR2pmbnlZM2pXWGljR0Fm?=
 =?iso-2022-jp?B?cGFBbS9zdGJkTkRwZ25jUUQxVFlNMUF0c3NDRnA5R2czWVN2Uk94eGN1?=
 =?iso-2022-jp?B?UVlmL1pmTlRnajJhRFBJL2Y2anI1UkVEdGFMa3hGTFppRFFyWTFCU3Z1?=
 =?iso-2022-jp?B?c053cDZzdy8rdVRnZW5XdFdzN2dveVVuSzFEQXJhdlhROTRKS3lIN3pr?=
 =?iso-2022-jp?B?MllQMEFPcVQ5U2YzdXVZeGlpb1ZTdy9kb0dQUEc4UkdYOGRUQUxsaExB?=
 =?iso-2022-jp?B?QzZEbklKOUl1eHlPVzE4QnRxb3NqaFI5ZGE0PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7472f8fc-f2cc-4638-b1b7-08dc85b93e2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 23:43:03.7984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YS8jdCVs1TDf3IC/yz+Mn9zW+Dfn1+mjQ8KAGRBYxBWla3AqjIHZnWyRW/wDYj3wDAxtcOROW3f/rNbf4hZsy+l54lRTAGyHlOWq4Vh6lAL9NABjmqZ+PCfyq9zySysR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8497
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Jun 2024 23:43:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16121

Hi all,

CIP kernel team has released Linux kernel v5.10.218-cip49.
This version has revised the build error of USB host driver. The base kerne=
l version is v5.10.218,
and has not been changed from the previous version.

You can get this release via the git tree at:

  v5.10.218-cip49:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      9b6b51fe8dad7c7e6e091bd99901171e42b1b80c
    Fixed CVEs:
      none.
    added commits:
      CIP: Bump version suffix to -cip49 after merge from stable
      usb: xhci-plat: Don't include xhci.h

Best regards,
   Nobuhiro


