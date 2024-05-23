Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4F4C25B75
	for <webhook@archiver.kernel.org>; Thu, 23 May 2024 10:40:40 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.53])
 by mx.groups.io with SMTP id smtpd.web11.13868.1716460833581631715
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 May 2024 03:40:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=bf2rCPmv;
 spf=pass (domain: renesas.com, ip: 40.107.113.53, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLvyo1MSFxbgX35NR662Oh+xyQZlaIaFPKiHu4jOasVPc64FQPLbzme4Rm+Cato9Wl5BzvdwyBMtvbFxhA4ceSORlIjOUOw16muPACPckRqr0aoqnxD3g0nn/EtZoJQX31ZcjffkiZTNA8tvG/XRtTIXQy4jIPnyobdgveZER86ySjCearHqPRICl/M9hSKw9UXphKNkY9oaxRf6QPEP88eyFyCOkgFxevvv5kqFBrjtOiyPi0iq0ZGNaxzUYobc/cq00kywNMPJKkRlKw3vqQWwlIj3keC4JX6I6pZnsxvHL1m/tE+9DulOpNvgb2xLCrMRse01p+oGVJPkxkk4HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZ5js9eTmekwWM0MPapIOAG52Qym6HNOh7tpIJ+s7qY=;
 b=B7uaw86AG0G4s5ELYlOyzsK9aIpNo71OmInxZnAYaoy/J9+EcOON3AbivSr0//vOlCxb4RKh8NvJd0ihvNtivtTXWvkWy243Cha8d4Nu782HoNE17JRzL/xHdE5xo3Rv3S+yFj78UcqX2oR+8Es/yMHHTnFBryDwwwitTwbetu2GHQ69RQ25J7z+4JmDxaaV7iARq9qeOYJALsaCmDyR+i5KSZbQNs3MMlhA5dlL/mjboPHO1HUlZ7W399j25gXVcicRtw4QXmvkCIqmOVajNFuVeRz9Xn+nh1Ku9zIHmBpiRcAETh/8ppv6Hi9A0UQhYsfJnuks3Q/8YjL/SBY9LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZ5js9eTmekwWM0MPapIOAG52Qym6HNOh7tpIJ+s7qY=;
 b=bf2rCPmvVMLGpZS0PKvyuhzmA8QX8m0TveqJKHj0VySgB40826eHZyLH2lnIPv+o0wWcSTvhCbdrv/lqFcrqjzSOi0pZBzD1ZuSbJ5W7HZ+O4maugghcIC3/OXoiEiKjcx9Cxl6D2spaHE9xCQtstycruQlzDVnIh3n1JUWafmI=
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com (2603:1096:400:3fc::6)
 by TYCPR01MB11416.jpnprd01.prod.outlook.com (2603:1096:400:379::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 10:40:29 +0000
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::fbad:9a9e:9e5:7cfa]) by TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::fbad:9a9e:9e5:7cfa%6]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 10:40:29 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "Sai.Sathujoda@toshiba-tsip.com" <Sai.Sathujoda@toshiba-tsip.com>
CC: "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: Request for updating device dictionaries
Thread-Topic: Request for updating device dictionaries
Thread-Index: 
 AdqmtLnvothy4nUKQBSdfu8qbwxdbQD6sUBwADL8pYAAAnF5gAAD935AAAJUSVAAW7ozMA==
Date: Thu, 23 May 2024 10:40:29 +0000
Message-ID: 
 <TYWPR01MB1186240D94D30961DEA74C5FEB7F42@TYWPR01MB11862.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103AFC364EE1AD1A9C0C81AC2EC2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <OS3PR01MB6103F00964E26A0F5D38A8ECC2E92@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYWPR01MB11862221FADD6EE25E032DADBB7EA2@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <da0d13f4-4721-4f79-92f0-2e20b9c2e7af@siemens.com>
 <TYWPR01MB11862ECCB6972DA686F96C20CB7EA2@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <OS3PR01MB6103AFEC697CE32DA84F113DC2EA2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB6103AFEC697CE32DA84F113DC2EA2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11862:EE_|TYCPR01MB11416:EE_
x-ms-office365-filtering-correlation-id: 49446701-86ee-4bff-78d4-08dc7b14c3cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?azNKNmY4THZyNWNzYkpIU09ud1BKK3BwREZKQ2hWeE1ib01PRm1tY3hEb2Yr?=
 =?utf-8?B?S1l1Wk5nMXFaQ0VqNjN2eFBLbi9BKzl4aEdhU1M0NW9qWmJNSlE4TVZxL3Ax?=
 =?utf-8?B?Q1MrYTAyZVNWTUZwOWwwam02eU9sSEJLWXhpK0Nsbk14eHF3OHQvQ1J4Wkoz?=
 =?utf-8?B?VUFNbzhCQlFjQStIeXBNY2p3STNKdXJHaE8ydGtBemdDTXN6U2dZVFRhK0JP?=
 =?utf-8?B?ZHVsYWtBK3B1K3ZFUU5TVUFwcXVTaWVVS0dBVVkremVUWHN0b2pab1FGOFFJ?=
 =?utf-8?B?Slh3WHhSMkoxS1c1Q1BYQ1I5dW03aDlMN2tRSDVETkZtZDhRSGo0ZGRGRnpC?=
 =?utf-8?B?RkNGNVhjdEt3ZXVXUDRQSy9HZ1FTUDBWbE9WRXFPaW5VSkxoUW5IWmovSVBm?=
 =?utf-8?B?WjQ2RVdaRzFhaDdKMFZ3dUZKbys5WFZCNlZTN1IrV3ZjRitqZ3BQalk3NnpP?=
 =?utf-8?B?em13M0tXTWFlYVQveStibXR1YkhTK3lnTXA0YVEyaEYvdDREY0VnZTJGVjJk?=
 =?utf-8?B?Y2R0K1FwOXd1dXBZcGVuYjE5SUhOZmd3WjJSbjBDRkZXWjdRR0JkYjU3WW9K?=
 =?utf-8?B?bDBnbnFDNGhRb0RIT1VhdUlBYStCY0wvcUQ3dXVHeksyWEo2cVF6M3RSd1FQ?=
 =?utf-8?B?YThLZ2xmREhhcDhBQ2JBOTRwaWdydFJqcnNnS2JGUWJNU1RHbEpRQzhmeTMy?=
 =?utf-8?B?NnhNeFNTT1N3REFIT0xPbjBnUW9zcmhEcHRYeXBvdERTeWV6YStyL0FNb01x?=
 =?utf-8?B?QksydjRLVFgvZ3hZanRpaitac1UrVHNwdjlyRkRSV3ErSmpHeUdLb3pGOG1G?=
 =?utf-8?B?dDZCSC8vdEhsYy9zNFdHVFZLYkM1eTZPSVZmSUhmZTN5OHk5Z2lOMkl2UmVy?=
 =?utf-8?B?RGprb2RlMUhDM1UwNElRR3E2cVhzbWMvSEh3RnYyRU1XbTRNUm1SYmJ4b2Vq?=
 =?utf-8?B?Z0dVeU9yNTZOYVh1QStuWnZNZjlhTHZFcG9FYlI5UER2QStPQ2ZrMHhqV0Ni?=
 =?utf-8?B?bEtONDFiQTdQSlRqZ3B6QjlsYXhmbUIwWFNuREtVYkhDeHlZQVhlSS81MUZ5?=
 =?utf-8?B?SjVKZjJjbzBLeWFGRXYwcFRJcXkzUzQ5a2FOQkk1UGUyVUtEdWlOZTJqUGpi?=
 =?utf-8?B?VGFWZmlSWFF0Y0ZqMWdpUUMrOFQvWnRLcjhSMHNQWXFVUXF3SU16OHgwak9S?=
 =?utf-8?B?elQ5cGsyb2M3c1JyLzBiSUdBRkxQUVVOVmRxbWFFM2oyYzlnaFA2RXg0c2xt?=
 =?utf-8?B?RnpyNEFvcnJQSjExb0haM21kNHlrMUxEQjc4Q3VpV0lDRlJLa3RnaTVua1ZB?=
 =?utf-8?B?ZHcvYjZvTm5MdUxiV1JWTzBtbUlTelduYVJNOGNncTZQQjhHQk8vOUUwUUoy?=
 =?utf-8?B?YzF5cjhKcnBXMkVscjEyUWJmU2laTTdoTHRFOGN2Y2xHSjd0V0JtMDU4SmFv?=
 =?utf-8?B?ZFFnSmdONjB3N283S0dQc2J1NE13cmNCaTB1RW1Ub1JlaVlVaVlSVkFBRGgw?=
 =?utf-8?B?b2lkVGpiVzFrUm1xVHh3UmR3R2N0d21aMDdvZFdxRG5EN29JalVxdDhicHpy?=
 =?utf-8?B?QU5jSUxzaStjeVZyUlo1K0xUcnAzU0NsR1ArODF4Z2didUU0N1JrOXg4cDB0?=
 =?utf-8?B?ZkJXVmJxTzB4TlNkUnlseHFhNmxFOWdKbzY5MWRGWkdicjBKOC9RWllBa1JZ?=
 =?utf-8?B?RmJoY20wdXhZYXAxTmJCcEc1NktaU1FGaEp6R0tGYi9aNENSd0JnWWwxV1N2?=
 =?utf-8?B?c3BZN08zUEFOVzFCVk5pN3pOL2IxV083UzFLeFIrN2hodnoyVmttZUFabG93?=
 =?utf-8?B?MFY2V0NBMFQyQ1hjc2xOUT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11862.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?QVJiWU0zOHZrL3B5djM4Kzdqb2lLNWJyTysrMElRbmhuaUw0Qld3RWpzRU5P?=
 =?utf-8?B?TkdNTFBveWU2VDQxeXlZL2pvYjFhN3p2MFZBU0tneFJKQzNXb0tCcHRTdFlT?=
 =?utf-8?B?Y3laQ0JXa25pbjIyYWdMRTZqUXB0TmlXVEpXZnM2dnVkK0ppdE16R2RGd3dX?=
 =?utf-8?B?Skt3Y29lNUpYN1VKN1dSWGhxZFB4T3U3amVCc2JDaWl4NEhqc2tvaGthUWYz?=
 =?utf-8?B?cWdKZVVhbzE3em5TbWNmcVZrS3ZOMmljaWJaVjFzbHFRaVlMWnBnRDlBbkRv?=
 =?utf-8?B?UmQxUllnWVlHMlFmWFhJSUZwU0pDSDdWU0xvbGZ2SVZWZkx6S1Q4Z3lZZE5u?=
 =?utf-8?B?SzVpTENCVXoxcUdMcVBZNlVLNTgzbmIwVlhDS2R6U0lBaXJZaEtMT1BkMzh6?=
 =?utf-8?B?RnJtWXQ0ckRjUE1lZVh2VTVWVnVYekxIdTRPZExRWHpaNTN4VzVJOGtuV3Vs?=
 =?utf-8?B?b2tVUS9vejhUemlxNHgxRVdiN3pPTXkzNXcwV0NYdXc3bitMRFhKN0RuNXQ1?=
 =?utf-8?B?QVQxUU1QdkROUkhzeXFqZEhsTTVYSDdEb1lUUnVUWTJHK2w3NGoxUmpveSto?=
 =?utf-8?B?b2VlQ29ZbHhYTnA3ekRHakYrZlY0VDJlREhHYmcrSjc0RFRmTitqUnpxNldp?=
 =?utf-8?B?b25Ic0VMeDgwTkFueS9TT0dGWm5nMk1VQ1B5MVc1RW9PdzQ3SmgzRDRNN3li?=
 =?utf-8?B?MGI4S01kbmVtMmpzajRlb2orQlcvQ09uMTgyUkx2UkJiNnBBK3VKYWo0ZzJ1?=
 =?utf-8?B?Vkl0MnNSanplNU1QWk9HYXBQK3VjeWJ1OUlHVXlpWWN6SVhKQ3N6c3VJSllG?=
 =?utf-8?B?aXJUN0FQRXFlZ1F4VzQ0RlVMbTYrcVp3NlpDb0pDYUtNbWIxZERoZkF2Zjlw?=
 =?utf-8?B?V0x2c0laYmkrdnAwaHNEQ0Z2TWlwWmpoZGtid0JDRy92WFFyZk82TWpha1NJ?=
 =?utf-8?B?RDVDMG82R0F3b0tBZk0raFNmSWZ3cGJyZ0duWmo4Mm9TUEVVbGRIQXQ5L0hq?=
 =?utf-8?B?bkNKSTBGTXQ0eVBZWUtST2s5UXdsa1pPYWdRS2Z6SVg0R0JPdVpzQTlhOWp1?=
 =?utf-8?B?MG41Y05LTnE1TDk0NTFybEpaYmFUaEZVb01BVWdUaU4xa1dKQ2s5bFhRa0ZF?=
 =?utf-8?B?dWFpRkN2SWs0UnpSSG5CdUdWMmlvcjlaRWx2RDcvdWo2Ynl0RWZMeXo5eXJD?=
 =?utf-8?B?dXNaa1l1SGJRRDNLdGpDUDhMeXRERFd0Q2hBeXJYai9SeXBhOWFFcmluUmJp?=
 =?utf-8?B?UEdrSkVreENheTNibloxSFlraUFnZ0cxeGZ5QjR2K3AvdHV5RThQVUh0OFBP?=
 =?utf-8?B?Y3JUNWFvRDZsaWF5SkxBMEl0cU42c3VWQStOUFMxelJwSHk4bVE1SVZ0UVU0?=
 =?utf-8?B?akhLMHRZU0NqM0t1TXZieDlra1B4a0w4dzFRQzE3NzBpeDArYjdjeXVFSkNR?=
 =?utf-8?B?bHovbHNMcmZxWW9PR0dIRStvNitNQis4MXRtNkg4Z1diT1ByQnlJTkVwd3ZN?=
 =?utf-8?B?WnJmOGVLL0k5R3BweDZCSVRWamJDbHBzT3g4Q0FSRE1XaXdya2ZTOUsybjNz?=
 =?utf-8?B?dm1HUUtMYmNiSnNhaEVuZ29Wd1F5SDZEdU81dW9oWnUwVzB0QlVFeVdXMGhq?=
 =?utf-8?B?MjQ4UG9vWGdQbHhxd2VROFFuQWZRb012eERrL1RuTVBybkZJeWJ4U2VCOGUx?=
 =?utf-8?B?RGtjL21BUzJoMmttUnAxRUJxUFFlVXlHQjNSK0RCWktldzlNYktUTmM5ZWRw?=
 =?utf-8?B?OWFWRjM4SzByVWFFR1kwSjE4c0R3U2V0UDJHTUUvS1ZkT1pDcERESDBVWkhh?=
 =?utf-8?B?SjQ5aGNUTjRMMDlYVS9ZNHJHRzByL3Q1S2d3Zld5S0RsdzM1QTR3Nml2SzlJ?=
 =?utf-8?B?TVhQUnk5TkNyY3diRXdIWlZBRHl4Yk1pS3dCb1JLRXlVRjZCejc5Q1BRaUFK?=
 =?utf-8?B?ZkxhTXN5NU9zTUNEQzJ3cjJzSnNvQktBdk9OSURUcGpwNXNxa3dhVUhxbXdV?=
 =?utf-8?B?THE0U1p2dkthS202Z1hnSEp1Rmx2aDVqT2U2b0s0RDVBclZIcmsvbUZPcFI0?=
 =?utf-8?B?eXNvcUJpcUJtaGdrZThIT0ZOUmZWU2lucmNqR2pwYjM3Q3ZrUEtHSVZ4aUtG?=
 =?utf-8?B?Wlhsd1pMK3ZhNjBudVV4S2VpY1hYb0dPUTllOWNNRm5RVW9YNkxaZWdhSnRR?=
 =?utf-8?B?Rmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11862.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49446701-86ee-4bff-78d4-08dc7b14c3cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 10:40:29.3953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eFeun3I0EqT5Ps8Gk1Kd8VMtrVEhHdp7pHvjeT+HaaVBJj6wshxlLnDLP12PhmTQaWi/Foh8vIL8Xukx/E3dCxPutoX+F86ckAOv8M1GUO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11416
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 May 2024 10:40:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15931

SGVsbG8gU2FpLA0KDQo+IEZyb206IFNhaS5TYXRodWpvZGFAdG9zaGliYS10c2lwLmNvbSA8U2Fp
LlNhdGh1am9kYUB0b3NoaWJhLXRzaXAuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBNYXkgMjEsIDIw
MjQgNDowNSBQTQ0KPiANCj4gSGkgQ2hyaXMsDQo+IA0KPiBQbGVhc2UgYWRkIGJlbG93IG1lbnRp
b25lZCB2YXJpYWJsZXMgaW4gaXNhci1jaXAtY29yZSBnaXRsYWIgQ0kvQ0QuIEFzDQo+IGRpc2N1
c3NlZCwgaXQgaXMgYmV0dGVyIHRvIGhhdmUgdGhlc2UgdmFyaWFibGVzIGF2YWlsYWJsZSBmb3Ig
bm9uLQ0KPiBwcm90ZWN0ZWQgYnJhbmNoZXMgYXMgd2VsbC4NCj4gDQo+IDEuIExBVkFfVVNFUg0K
PiAyLiBMQVZBX1RPS0VODQo+IDMuIFNRVUFEX1RPS0VODQoNCkkndmUgYWRkZWQgdGhlIGJlbG93
IHZhcmlhYmxlczsNCkNJUF9MQVZBX0xBQl9UT0tFTg0KQ0lQX0xBVkFfTEFCX1VTRVINCkNJUF9T
UVVBRF9MQUJfVE9LRU4NCkNJUF9TUVVBRF9VUkwNCg0KTGV0IG1lIGtub3cgaWYgdGhlcmUgYXJl
IGFueSBvdGhlciB2YXJpYWJsZXMgeW91J2QgbGlrZSBtZSB0byBhZGQvYW1lbmQuDQoNCktpbmQg
cmVnYXJkcywgQ2hyaXMNCg0KPiANCj4gS2luZGx5IGFkZCB0aG9zZSB2YWx1ZXMgd2hpY2ggYXJl
IGhpZGRlbiBpbiBMaW51eC1jaXAtY2kgcmVwb3NpdG9yeSBmb3INCj4gdGhlIG1lbnRpb25lZCB2
YXJpYWJsZXMuDQo+IA0KPiBUaGFua3MgYW5kIHJlZ2FyZHMsDQo+IFNhaSBBc2hyaXRoIFNhdGh1
am9kYSAoVCBTIEkgUCkNCj4gDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IENocmlzIFBhdGVyc29uIDxDaHJpcy5QYXRlcnNvbjJAcmVuZXNhcy5jb20+DQo+IFNlbnQ6IFR1
ZXNkYXksIE1heSAyMSwgMjAyNCA3OjE3IFBNDQo+IFRvOiBKYW4gS2lzemthIDxqYW4ua2lzemth
QHNpZW1lbnMuY29tPjsgYXNocml0aCBzYWko77y077yz77yp77ywKQ0KPiA8U2FpLlNhdGh1am9k
YUB0b3NoaWJhLXRzaXAuY29tPg0KPiBDYzogZGluZXNoIGt1bWFyKO+8tO+8s++8qe+8sCBUTUlF
QyBPREcgUG9ydGluZykgPGRpbmVzaC5rdW1hckB0b3NoaWJhLQ0KPiB0c2lwLmNvbT47IGhheWFz
aGkga2F6dWhpcm8o5p6XIOWSjOWujyDvvKTvvK3vvKUg4peL77yk77yp77yn4pah77yt77yw77yz
4peL77yt77yw77yUKQ0KPiA8a2F6dWhpcm8zLmhheWFzaGlAdG9zaGliYS5jby5qcD4NCj4gU3Vi
amVjdDogUkU6IFJlcXVlc3QgZm9yIHVwZGF0aW5nIGRldmljZSBkaWN0aW9uYXJpZXMNCj4gDQo+
IEhpIEphbiwNCj4gDQo+ID4gRnJvbTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNv
bT4NCj4gPiBTZW50OiBUdWVzZGF5LCBNYXkgMjEsIDIwMjQgMTI6NTEgUE0NCj4gPg0KPiA+IEhp
IENocmlzLCBoaSBTYWksDQo+ID4NCj4gPiBPbiAyMS4wNS4yNCAxMjo1NCwgQ2hyaXMgUGF0ZXJz
b24gd3JvdGU6DQo+ID4gPiBIZWxsbyBTYWksDQo+ID4gPg0KPiA+ID4gWW91IG5lZWQgdG8gdGFs
ayB0byB0aGUgbWFpbnRhaW5lcnMgb2YgdGhlIGlzYXItY2lwLWNvcmUgcHJvamVjdCB0bw0KPiA+
ID4gZ2V0IENJL0NEIHZhcmlhYmxlcyBzZXQgdGhlcmUuIEl04oCZcyBub3QgbXkgcHJvamVjdCBz
byBJIHNob3VsZG7igJl0DQo+ID4gPiBtYWtlIHN1Y2ggY2hhbmdlcy4NCj4gPg0KPiA+IElmIHlv
dSBoYXZlIGFjY2VzcyB0byB0aGUgdmFsdWVzLCBqdXN0IGFkZCB0aGVtLCBDaHJpcy4NCj4gPg0K
PiA+IEJ1dCB3ZSBtYXkgbmVlZCB0byB0aGluayBhYm91dCB0aGVpciBhY2Nlc3NpYmlsaXR5LiBJ
J20gY3VycmVudGx5DQo+ID4gc2VlaW5nIEFXU19BQ0NFU1NfS0VZX0lELCBBV1NfU0VDUkVUX0FD
Q0VTU19LRVkgYW5kIEtFUk5FTENJX1RPS0VODQo+ID4gb25seSBtYXNrZWQsIG5vdCBsaW1pdGVk
IHRvIHByb3RlY3RlZCBicmFuY2hlcy4gTm90IHN1cmUgaWYgdGhhdCBpcw0KPiA+IGZpbmUgYW5k
IGlmIHRoYXQgYWxzbyBhcHBsaWVzIHRvIHRoZSBuZXcgdmFsdWVzLiBPVE9ILCBpdCBwZXJtaXRz
DQo+ID4gZXZlcnlvbmUgd2l0aCB3cml0ZS1hY2Nlc3MgdG8gdGhlIHJlcG8gKHdlIGRvbid0IHRh
a2UgbWVyZ2UgcmVxdWVzdHMpDQo+ID4gdG8gcnVuIHBpcGVsaW5lcyBhbmQgZGVwbG95IHRoaW5n
cy4NCj4gDQo+IFBlcmhhcHMgaXQncyBva2F5IHRvIGxldCB0aGVzZSB2YXJpYWJsZXMgZXhpc3Qg
Zm9yIG5vbi1wcm90ZWN0ZWQgYnJhbmNoZXMNCj4gYXMgaXQgd291bGQgYWxsb3cgcGVvcGxlIHRv
IHB1c2ggdG8gaXNhci1jaXAtY29yZSB0byBzZWUgaWYgdGhlIENJIGdvZXMNCj4gdGhyb3VnaC4N
Cj4gSSdtIGFzc3VtaW5nIHRoYXQgb25seSB0cnVzdGVkIGRldmVsb3BlcnMgY3VycmVudGx5IGhh
dmUgd3JpdGUgYWNjZXNzIHRvDQo+IHRoZSByZXBvc2l0b3J5Lg0KPiANCj4gQ2hyaXMNCg0K

