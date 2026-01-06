Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94552C47BDE
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 09:54:57 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.32])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.86775.1767693291509030400
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 01:54:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=vIVl9VkQ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.32, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVPJ5x8vGWEuL/0pKAvpAC3+BuHFjFRR0+plM2KpY7yDJnpaPbJfUzt3SSzpmvLeP+aoXPopZ2/DKa1AmJh0b8EhQkFct0Q7youHn05unHAK2NrcEXfKgNPPxiyMGNZ75JugMic6vXQ2SxEfgZ4+tcAXPxxBgKmN953TYcz1KQGyUI7BpYuTmrEO24cTgtGeE64cvR7zqv1BivpOvMnam8gnNxjGp87lJi/eKOZ7dfM9INBX1wxWLgJeIQDc+dqyHPFI6+CGJtkzIUJzeSkYp3ij0pTx44GCbWdS5eMRMQ9bFaeuWcGmRQ5GTO/8LgWq+vAgrV1EN+0Df503Ke1BdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVEwCAvESYpJSR9eTRHVgNYScx9irr6cVi2SkOtCzgA=;
 b=zKdrYiCwmrjgkrwKl56HLWOKzrZ8l8uilN3Iz2zRL3pwuuy1qM0DuivgeEhU5+//jA/X7i/TV2q/BzdAwCv2oF3NEeUuMFrbdOcoNfCjt2QYKkCXdZ/vJYZlGySCErns4MIXGZfvUW77d6gjpyP4whqTny7hcAN2Spfd0UM9OTS4gqM4vjaezn1442ODDS+4WOsPoYIZVH9G45qzoT9GO2GIGCm32RYiRTBOpcYNcmNi2vqAQHMWC1pJtvUQ4mGZ/u8ZXB0+q1BiihmNez7jiqLzQyvaSy2/TLavUjDS3IO8o6pyDau2vL4g3AKEMxZ4p/nCz28YsSZ2jt1brPolZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVEwCAvESYpJSR9eTRHVgNYScx9irr6cVi2SkOtCzgA=;
 b=vIVl9VkQlQJtWFbWmImywuS+WyFthLM6NAVEqCqHbavYSl3yrvrb+GM4fjbir2QfD4r17YgsMIjaqS0IeLTLz/3pFKJREUjA9GppfId2zFV8Ey8wJv4Qwk62u2P4KoLPN9iI8Fey18LM9gQlGYhFqrmCLDDYDz65oORugm3ST0g=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSCPR01MB13024.jpnprd01.prod.outlook.com (2603:1096:604:333::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.1; Tue, 6 Jan
 2026 09:54:47 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9499.001; Tue, 6 Jan 2026
 09:54:47 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH for 6.12.y-cip + 6.12.63 ] can: rcar_canfd: Fix build
 error caused by is_gen4()
Thread-Topic: [PATCH for 6.12.y-cip + 6.12.63 ] can: rcar_canfd: Fix build
 error caused by is_gen4()
Thread-Index: AQHcfd+pY+coh/wWykqX9mehHuUtRLVDRJkAgADc8YCAAMb0sA==
Date: Tue, 6 Jan 2026 09:54:47 +0000
Message-ID: 
 <TY3PR01MB113469B5BC2D59B29C590EAA68687A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: 
 <1767574966-5745-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <TY7PR01MB148184F8D88C0BC3643171681CD86A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <TY3PR01MB11346883D7A93A1538A1D5EC98686A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY7PR01MB148184B738A3B59788E717DF3CD86A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY7PR01MB148184B738A3B59788E717DF3CD86A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSCPR01MB13024:EE_
x-ms-office365-filtering-correlation-id: 751f4f3a-587e-4c20-9f6f-08de4d09a051
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?MnkyaGJvb3JUUGIrMXBUMEt3Vkh5VG1wdm9zeUI3VEh3TkJ6NzBMcmlabmQr?=
 =?utf-8?B?djkxbGhSOFAwb3RDUkF0OC9zdi9EWjhUOC9sc3FHbTU1RDNFRDVzV081SVRN?=
 =?utf-8?B?cDZuVjdweVRqY1FzVng2RTdNbWRjakJORjg3L1ZlenoxUnUwZGFyblBDSWNU?=
 =?utf-8?B?RTBwejZLVEt2dmVrUzhaL0s2djcwL2c5SEhMNmpIblNpVDRDR3pGN2ptbkZ5?=
 =?utf-8?B?YWY3K2x0aGw3cWRBYWtJSjYrNjc1R2pMblBTRkR2OVNUUllWZjh6MFVCUDlR?=
 =?utf-8?B?MWwwbWJXelFPTHVIQ2dqUjBpM0NnRC9YZmk1UXZ5elUySitFQ0FZUk5xZlJT?=
 =?utf-8?B?Sm03alN4OEIwS1BQYk5qdzdoY0lIWHV0WTVLMG04OXhvcXIrVUl0Y09rUlRN?=
 =?utf-8?B?SDYzOFAvWnU4Z1ZiUmFWMXF5TGwvOXo5RWJ5SjJMRXV0SUQyUWRqWnAyVWJi?=
 =?utf-8?B?S0VUZ1hlVWE3OTJ5RG9FL3pjWlV0azNlSmhIcEdQdW1zSmRJdWJxTjI0WS90?=
 =?utf-8?B?dmEyTkppdG5RdUlNbHUyc3JSaEN3ZXk0Q3lBOWNJVkIvaFdDbWJsQ0swNE5v?=
 =?utf-8?B?SXFiMmRoRGY3NlVidmt2VEczOXZOdDBJSHBtdHRCeHdtaGdQOWR3c2N4ZnV1?=
 =?utf-8?B?d2ZpQWdVUlBCaDh5Z05YSTlBSTRHRWlYaXhadGZJMnV4VGtUdlREdEFBUXRl?=
 =?utf-8?B?WVdHdGRCWGo0eUkxT3drN3N2YkRvUmJIeFZtbnJyZTJoa1ZMTXN3U01wdmdx?=
 =?utf-8?B?RWsxTEZCR1BWUVcrcDF0NlREcTdSMko1RVkzYXpQK3BRWmYyVkpwZnZjM1dO?=
 =?utf-8?B?Qk9VQmRoSlpQNDdYdXNTS3ptTVVYaUxhYlVEYU1WTExGbEUzYy96U1VmVXg2?=
 =?utf-8?B?L2g4TmppUFBxdUlCYlp2c3RQNGlsUGV0N1YreE9KL2h1RFJOcUhTaFd6cGd2?=
 =?utf-8?B?VTVoaCt4dHR3ZG1CZzBiQ0EvQy9NTXp0dVFzQUo4dDZ5ZThpVXNWODRIblJ6?=
 =?utf-8?B?STlmbXRpVkNxcDNZSXoySHk4NE9zcXVhUVl5ZlBjblNadjJMZ0lFN0hRU0RD?=
 =?utf-8?B?Vk4vY3I3SitqKzR2SzdrWHN2bCtsekNuWWVzZGg0dEFjT1ZJSHAzYmxFYjVZ?=
 =?utf-8?B?S2dlTUh6SmtWVGdweWl3SjJ3V2RsRkhHSEZRNzUycU9SOHBTTURFUTlJQmxF?=
 =?utf-8?B?ZU9tUzROYXN3SmdXWlJ4U0t0c1l6Ulg0VlZqN1Ixc3A3Y1E3L2RZS2F6OFQ5?=
 =?utf-8?B?S0RZZ0VvZmVoNVo0Y010TkZiSG4yb2M4NUxPT1BzdzZTYWk3Vk45bzU1c2RB?=
 =?utf-8?B?eS9RZnZhalJhcEpBRWE3bmtIUEF3cWhSUS9HblVrMUZaZW1vSVM5bzJHQjhr?=
 =?utf-8?B?dy9HM2VlYXFubnBZRmFTTC9mZUNTTFZqeGZPR211anlsdno5cnN6TG1pWjhP?=
 =?utf-8?B?VkdRK3E5d3c0UVprS2NabUpiUzcxRFg0RjVnL0JaeFJMbmhZdS94ZjhvTXVU?=
 =?utf-8?B?Y2xrQkVOSTBpVU5ySnBLLzFjajZUcXNXdEZIdHNjMHB2NUxpbkpNVXV0SUwx?=
 =?utf-8?B?cEVUVmQ1VTliWWpLcUU3bTBBSFdFUnZKSGZ6Q09Jd1hub2x6Rk5IYUNZNDNx?=
 =?utf-8?B?Y2xsQ2tIUndwb1dMbDJhazUweVoxWEJjcGhVYlJVRkZYcldlcXI3clB2TTE1?=
 =?utf-8?B?KzVaYjZ5dFFCek1RWk9GbDdpcVNnb1JOREVkZitDM1RLbjROZnpmbm93YWhK?=
 =?utf-8?B?anRKK1JIbWlRam13Wmk2V1RCN0xkVTA3TUk2aVFLU2ZBSjZPemlaRnFkbDhV?=
 =?utf-8?B?RmVtbHB0eHhJZGFIcjVkNExYS1BRVVJXb2ZqR3A4U1pDQlF6ZmZ1azBmbXRP?=
 =?utf-8?B?U2ZpeERUQWs5UWtxM1AyUi9ESWhnMjRJK3pyU3MrOThtNkZaUkJOek44NWh6?=
 =?utf-8?B?RmlNM2pGQTNYd0NRM213TFJMYU55T2dRUWJRd1QwUU5lWkplcERLZm5EdUpK?=
 =?utf-8?B?OUlGdjRrZkpPS1hpL3FwZjBXWCtDYzY4WjN1cW1wd3V1dHJLWVZuS3ZlYk41?=
 =?utf-8?Q?PV3Qrz?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aGZZbjhOVHBtQk1CSjRIcnllYngxZ01NcjhjL25PN2gvQ042QWVKUVZNUE5G?=
 =?utf-8?B?SzNSMENkcDJ6QnhYR2FxWkFJdUdNL2Jjem9Rdll4cFZHaWhxcXB1cndYcDJQ?=
 =?utf-8?B?SVRwOHNuTVM4aDdQWDBCS1JnQ1B6VDRPSlN6MGVSS1AveWI1VzFFWHN4UXdR?=
 =?utf-8?B?OXUvYjBmcFI0S1ZDeGJONGY3a2JyVmxxS1QrakwwQk95THZQQnowc3FTb2Vw?=
 =?utf-8?B?dVpEd1kwZ2U0QVZhVkZWSHRaKzZqSHhPbU85T1lqemhZbGIram9XN0JiNGlE?=
 =?utf-8?B?YzdmY1I3MDB0bGhEOHJBVjRRb3F4cmUvcWZaZTZlV0huY1dJR3hxaGZoajBD?=
 =?utf-8?B?ZVpQdmRNVnN2cWxmTEY3cTJwN01BY2ZiZStFK3d1cVl5MTM5eTRhUVlyc1By?=
 =?utf-8?B?eHVFOEROSDh2VE5WYWRpaEowTkU3TW42SGJWT0lneHNha1pVQnZCeTNrTTdZ?=
 =?utf-8?B?YlFmamhWRUFjT3V1RElaVGkrOUdPWnYrSW1pQU9zQ0NZZytqdWRZL0NzYW9i?=
 =?utf-8?B?TGI5eFpqaGd5Q0lSRXlvalhvOWpOa3M3NkN4WDRZcFNNSGhGMVlqRTFOdE9N?=
 =?utf-8?B?ZVNxR09Lak4zbXhtN0VuMGNFazcyNkNNTFBvdXJteTZ3bVF6SGVTekYvVjNH?=
 =?utf-8?B?eGsySmNEWWhkSTZBRmtnWFhoMVhmZStNemxFWGs5eHpaTS9yUk9tMy8yN2hQ?=
 =?utf-8?B?V0JJdnFIdEc4cE9CbHkrUkZGTUtLS1pUYVVVUDF3WUk5U25ieWF6VXBjbGNR?=
 =?utf-8?B?dzlqbzZFVDNRNXZaUHR5SitxUnpBc08zd0VEbER3cG9lVjZYQ0wwZnVnOHVR?=
 =?utf-8?B?dS9RS3RoNkhoK1dhM2dzRkNwdHRMSnQrRTk1eW5wY0N5RlgyN3NrbnlFR3di?=
 =?utf-8?B?Mm9TeG5ocWlXOEF2Uy9ra3cyMWllaFZLbDNYNHo4MjdJd0w5bWZDakEvb3kr?=
 =?utf-8?B?bUhVemc0SmcrRXp4Uk9ZcE9jdGV2Z1VlM1NDRjB6OHk0MDFHNzNuU3htOWR3?=
 =?utf-8?B?VFJlUjQ3WGF3aE9VRk50TFJ2anZRLzducUdiYnV3dlBFRmsvbHVDM1M3SWNW?=
 =?utf-8?B?QnhBUktCdTlNOVNLbjRsUkYrMkJDeGdzdFo3Uzd2M1lGK3JhZHV2aGZyeFZp?=
 =?utf-8?B?RWMxNUREd09wWDl2M2lqcUFVcVZKUnBLNGFHN2Y2aGNBaUVJL1VWN0pTM3o2?=
 =?utf-8?B?WmliVUhIYW9NcFFYUGhkSUJCeUtEZ1R2MEs5dzV2amhMUHdlV2RnYU9qNXlK?=
 =?utf-8?B?aU5TRVFIWkdmRFg5aEViazRaR0pENzE2RkFQcWxOVU4yVTQ3ZEFQSGRQSXpE?=
 =?utf-8?B?Y0prUmVzVmt3bHlmbjFwQVgyaEZ2cWRTSXk4dFhPL0w2QzgxYWRYQzM5aEVr?=
 =?utf-8?B?RVNrbnB4eCszMlJ5WklpSmEvOU9RUzh2TFYyWVRzNVcxek5FV0svQ0pZTlZs?=
 =?utf-8?B?dlBYdEpVRVl5eEF1cEE5dHJ4U3U0U0JJQ1JTS1hTZmhQdkJ4MGltemNEZzJU?=
 =?utf-8?B?N1U3M2lFVlEvZTREQ0creGRiUU5PQWFRQjNXdXpJK2dxcEtmOFMwUmtuWUFp?=
 =?utf-8?B?VDlHdWgxd21iUGFGWThNUmo5dXZMQndTMVFzMFZlQ3J3djlUclhRZ3ptckdl?=
 =?utf-8?B?N1VVMlNpVTZkL1A2bElkcVdvTG1FM0x4RkczZEZuMjlBdUVVR2dYV00wN0N1?=
 =?utf-8?B?UHBhTVVhY3lVK3hHL0JaQW5XblorNFBLUndVSTVLOUdrK2tIcVVObGJZN2RX?=
 =?utf-8?B?UVRoQUxSVncvK2EvNi9TZlhhSTdiS0VRWDN0cUJja2Fkd0pvbWdYeXR4S0VX?=
 =?utf-8?B?bFBsaGdrS09uWVd2V3dNcTE3b1hOYXF2MVlYK3pTTllQMVNtU2J2OWsrekgy?=
 =?utf-8?B?dG1FVFZKbzZrU24yaC9rVHl2NXBjZ3BjYW1Id284WG1kQjZuNURMK3dyZXM0?=
 =?utf-8?B?NjcwWnoxUTc0a2NTZkN1RWx4QnExd1dQYWZ3ZHNDei9BUWhOSFdxaHBBbzJY?=
 =?utf-8?B?UW10RE41TCthM0lpcmN1M3FLa0VwYkNpbkxyUjk0VmcrZHcxYzBoem5Memwz?=
 =?utf-8?B?SmdtYVN5cFREQm4yaXc5MjAvWVRMLzRXdllSdVlTSHNkTzkxNW0yaDJQalBN?=
 =?utf-8?B?LysxeUFiWFJ6TXhnNEdjUGVabnNLekdBK2pDbit1dVl6OG5VVytocUhxZXFw?=
 =?utf-8?B?elE3bFB5NFNtRG1XMjJDZ1JrOFlzSm1NWU1xUC9RNzBiSUpINE9BV0NDRHRV?=
 =?utf-8?B?a1ArQlQ2T0pBcW5yTWFaWnBjVFQyY2VSSUhXRFFrWDBBZjRVU2YrNVVQQVMv?=
 =?utf-8?B?TjFobEJSdVdQc1puM2JMOCs1NUVXVTJOY3Q2VWdSYmV0cDdhTTl4Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 751f4f3a-587e-4c20-9f6f-08de4d09a051
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2026 09:54:47.2813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MozMAbSngP5oGxem4Cx1XmMcNVjRs9l/nnlUxL/UcmDxI5RHw5xXk787IXSb6t4QhKXaawqcQTxP2KWaB88l3Pvn4tNZd2eeIVQgtiLw5O8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13024
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 09:54:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21322

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbm9idWhpcm8uaXdhbWF0
c3UueDkwQG1haWwudG9zaGliYSA8bm9idWhpcm8uaXdhbWF0c3UueDkwQG1haWwudG9zaGliYT4N
Cj4gU2VudDogMDUgSmFudWFyeSAyMDI2IDIyOjAwDQo+IFRvOiBCaWp1IERhcyA8YmlqdS5kYXMu
anpAYnAucmVuZXNhcy5jb20+DQo+IENjOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0K
PiBTdWJqZWN0OiBSRTogW1BBVENIIGZvciA2LjEyLnktY2lwICsgNi4xMi42MyBdIGNhbjogcmNh
cl9jYW5mZDogRml4IGJ1aWxkIGVycm9yIGNhdXNlZCBieSBpc19nZW40KCkNCj4gDQo+IEhpIEJp
anUsDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogQmlqdSBE
YXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+IFNlbnQ6IE1vbmRheSwgSmFudWFy
eSA1LCAyMDI2IDU6NTEgUE0NCj4gPiBUbzogaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0
iyDilqHvvKTvvKnvvLTvvKPil4vvvKPvvLDvvLQpDQo+ID4gPG5vYnVoaXJvLml3YW1hdHN1Lng5
MEBtYWlsLnRvc2hpYmE+DQo+ID4gQ2M6IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+
ID4gU3ViamVjdDogUkU6IFtQQVRDSCBmb3IgNi4xMi55LWNpcCArIDYuMTIuNjMgXSBjYW46IHJj
YXJfY2FuZmQ6IEZpeA0KPiA+IGJ1aWxkIGVycm9yIGNhdXNlZCBieSBpc19nZW40KCkNCj4gPg0K
PiA+IEhpIE5vYnVoaXJvLVNhbiwNCj4gPg0KPiA+IFRoYW5rcyBmb3IgdGhlIHBhdGNoLg0KPiA+
DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogbm9idWhpcm8u
aXdhbWF0c3UueDkwQG1haWwudG9zaGliYQ0KPiA+ID4gPG5vYnVoaXJvLml3YW1hdHN1Lng5MEBt
YWlsLnRvc2hpYmE+DQo+ID4gPiBTdWJqZWN0OiBGVzogW1BBVENIIGZvciA2LjEyLnktY2lwICsg
Ni4xMi42MyBdIGNhbjogcmNhcl9jYW5mZDogRml4DQo+ID4gPiBidWlsZCBlcnJvciBjYXVzZWQg
YnkgaXNfZ2VuNCgpDQo+ID4gPg0KPiA+ID4gUmVzZW5kIHRvIEJpanUgRGFzIDxiaWp1LmRhcy5q
ekBicC5yZW5lc2FzLmNvbT4gLg0KPiA+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4gPiBGcm9tOiBOb2J1aGlybyBJd2FtYXRzdSA8bm9idWhpcm8uaXdhbWF0c3UueDkw
QG1haWwudG9zaGliYT4NCj4gPiA+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSA1LCAyMDI2IDEwOjAz
IEFNDQo+ID4gPiBTdWJqZWN0OiBbUEFUQ0ggZm9yIDYuMTIueS1jaXAgKyA2LjEyLjYzIF0gY2Fu
OiByY2FyX2NhbmZkOiBGaXgNCj4gPiA+IGJ1aWxkIGVycm9yIGNhdXNlZCBieSBpc19nZW40KCkN
Cj4gPiA+DQo+ID4gPiBpc19nZW40KCkgaXMgdW5kZWZpbmVkIGJlY2F1c2UgaXQgd2FzIG1vZGlm
aWVkIGJ5IGNvbW1pdDoNCj4gPiA+IGYwYjM3ZjJjYjIyNA0KPiA+ID4gKCJjYW46IHJjYXJfY2Fu
ZmQ6IEFkZCBzaCB2YXJpYWJsZSB0byBzdHJ1Y3QgcmNhcl9jYW5mZF9od19pbmZvIikuDQo+ID4g
PiBUaGlzIHJlcGxhY2VzIGlzX2dlbjQoKSB3aXRoICdncHJpdi0+aW5mby0+c2hhcmVkX2Nhbl9y
ZWdzJy4NCj4gPiA+DQo+ID4gPiBgYGANCj4gPiA+IGRyaXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJf
Y2FuZmQuYzogSW4gZnVuY3Rpb24g4oCYcmNhcl9jYW5mZF9yZXNldF9jb250cm9sbGVy4oCZOg0K
PiA+ID4gZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jOjg3NDoxNDogZXJyb3I6IGlt
cGxpY2l0DQo+ID4gPiBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhpc19nZW404oCZIFstIFdp
bXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0NCj4gPiA+ICAgODc0IHwgICAgICAgICBpZiAo
IWlzX2dlbjQoZ3ByaXYpKSB7DQo+ID4gPiAgICAgICB8ICAgICAgICAgICAgICBefn5+fn5+DQo+
ID4gPiBkcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmM6IEF0IHRvcCBsZXZlbDoNCj4g
PiA+IGBgYA0KPiA+ID4NCj4gPiA+IEZpeGVzOiBmODhiYTUwOThlODMgKCJjYW46IHJjYXJfY2Fu
ZmQ6IEZpeCBDQU4tRkQgbW9kZSBhcyBkZWZhdWx0IikNCj4gPiA+IFNpZ25lZC1vZmYtYnk6IE5v
YnVoaXJvIEl3YW1hdHN1DQo+ID4gPiA8bm9idWhpcm8uaXdhbWF0c3UueDkwQG1haWwudG9zaGli
YT4NCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNh
cy5jb20+DQo+ID4NCj4gPiBDaGVlcnMsDQo+ID4gQmlqdQ0KPiANCj4gVGhhbmtzLCBhcHBsaWVk
Lg0KPiANCj4gTm9idWhpcm8NCj4gDQo+IA0KPiA+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJz
L25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMgfCA0ICsrLS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMNCj4gPiA+IGIvZHJpdmVycy9u
ZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jDQo+ID4gPiBpbmRleCBiNTg4OTUwODRlYTJhLi45OWQw
Y2JlODYzMjEzIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9j
YW5mZC5jDQo+ID4gPiArKysgYi9kcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMNCj4g
PiA+IEBAIC04NTEsNyArODUxLDcgQEAgc3RhdGljIGludCByY2FyX2NhbmZkX3Jlc2V0X2NvbnRy
b2xsZXIoc3RydWN0DQo+ID4gcmNhcl9jYW5mZF9nbG9iYWwgKmdwcml2KQ0KPiA+ID4gIAlyY2Fy
X2NhbmZkX3dyaXRlKGdwcml2LT5iYXNlLCBSQ0FORkRfR0VSRkwsIDB4MCk7DQo+ID4gPg0KPiA+
ID4gIAkvKiBTZXQgdGhlIGNvbnRyb2xsZXIgaW50byBhcHByb3ByaWF0ZSBtb2RlICovDQo+ID4g
PiAtCWlmICghaXNfZ2VuNChncHJpdikpIHsNCj4gPiA+ICsJaWYgKCFncHJpdi0+aW5mby0+c2hh
cmVkX2Nhbl9yZWdzKSB7DQoNClNvcnJ5IEkgbWlzc2VkIGl0LCBJcyBpdCBwb3NzaWJsZSB0byBj
aGFuZ2UgdGhpcyB0byBzaGFyZWRfY2FuX3JlZ3MtPmNoX2ludGVyZmFjZV9tb2RlIHRvIG1ha2Ug
aXQNCnNhbWUgYXMgbWFpbmxpbmUgWzFdPyBTYW1lIGZvciBiZWxvdy4NCg0KWzFdIGh0dHBzOi8v
Z2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25leHQvbGludXgtbmV4dC5n
aXQvY29tbWl0Lz9oPW5leHQtMjAyNjAxMDYmaWQ9NmQ4NDlmZjU3MzcyMmFmY2Y1NTA4ZDI4MDAw
MTdiZGQ0MGYyN2ViOQ0KDQpDaGVlcnMsDQpCaWp1DQoNCj4gPiA+ICAJCWlmIChncHJpdi0+ZmRt
b2RlKQ0KPiA+ID4gIAkJCXJjYXJfY2FuZmRfc2V0X2JpdChncHJpdi0+YmFzZSwgUkNBTkZEX0dS
TUNGRywNCj4gPiA+ICAJCQkJCSAgIFJDQU5GRF9HUk1DRkdfUkNNQyk7DQo+ID4gPiBAQCAtODgw
LDcgKzg4MCw3IEBAIHN0YXRpYyBpbnQgcmNhcl9jYW5mZF9yZXNldF9jb250cm9sbGVyKHN0cnVj
dA0KPiA+IHJjYXJfY2FuZmRfZ2xvYmFsICpncHJpdikNCj4gPiA+ICAJCX0NCj4gPiA+DQo+ID4g
PiAgCQkvKiBTZXQgdGhlIGNvbnRyb2xsZXIgaW50byBhcHByb3ByaWF0ZSBtb2RlICovDQo+ID4g
PiAtCQlpZiAoaXNfZ2VuNChncHJpdikpIHsNCj4gPiA+ICsJCWlmIChncHJpdi0+aW5mby0+c2hh
cmVkX2Nhbl9yZWdzKSB7DQo+ID4gPiAgCQkJLyogRG8gbm90IHNldCBDTE9FIGFuZCBGRE9FIHNp
bXVsdGFuZW91c2x5ICovDQo+ID4gPiAgCQkJaWYgKCFncHJpdi0+ZmRtb2RlKSB7DQo+ID4gPiAg
CQkJCXJjYXJfY2FuZmRfY2xlYXJfYml0KGdwcml2LT5iYXNlLA0KPiA+ID4gLS0NCj4gPiA+IDIu
NTEuMA0KDQo=

