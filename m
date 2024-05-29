Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0423BC25B75
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 13:08:00 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.59])
 by mx.groups.io with SMTP id smtpd.web11.13621.1716988070193206894
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 06:07:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=PkyH5YOh;
 spf=pass (domain: renesas.com, ip: 40.107.114.59, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROULkf9yDpRnhuuaSWi5UPja9LuGNOnkGBXBR4Xgj8vY0uYfFa8O9lC5yvTsNR9Y+6kyKoYHivalFKm1qpn15iiNKJAJ4IU36EC8tKqLYwlySo4/Ky7ROmqCU4dyjlToBqsiX5+e+9zisdV8nNml2y7vVskdcDXpXjqZ/UhwNy6hS9a1ZpvINNCqRDXcqi6k0QEc35bH0KJke0lzWpjfMTVpmQ5wyEDfIwb+eMUzLlNrzHXKL2tSPJUuffLh2zGsP1du/sgE3aitCql83LHhVBZdNTo/pfovn82+CFGZfodQi1e1Kvxa0T+mQEWcURR0tRye6ePkqvpiOIHKdxOc3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+FIR295jHZ6f9dizLvUxZFgKl//MAn1a2zG89ZyvPeo=;
 b=T5e5mrbi4A5tbNACkIQ7k7/kzzSTodzGRx4r69pi6OcGtmk+fmI2jDDNtdsa+UI/A2eelx/0thqazrW8d3D0rPCcpxpw5t4QtZ6RoeArgHfX4N8L+ZP/QRdnqzncKDFI+SuZ385o5oPDS9ZDgU+c5nognACF3xVxWxbfB4/dvbtNaGC/Wa4UAN/hfZg0quo/ZcBHCcLOoED2f06WZw9eRQqrAEABx+EPQWhUloL0JNmh5oml8QntqMcwcQ6CYQ7fh248xdTLCL0LzUEROYl987DuosBDiMfI2YZ00naZomxDc8lhKOJYOlhKG7fF/KA5g+OAOuTxosSrtf1TODYSIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FIR295jHZ6f9dizLvUxZFgKl//MAn1a2zG89ZyvPeo=;
 b=PkyH5YOhyOODI4HEKjGernNCnP3nA9BEGd/1HdJ0tV49qRvF+epO4Ti8Y7V/aQpWax4Brr2C1uy4xuHp/ewCpgE2HncS8bsWYwNw6vPwp/jqCe2VcLwLsTp5tL8YG5saVIRM42AErud4qoz7ICqgxlG3a+HJxREjavEBSmVDlYE=
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com (2603:1096:400:3fc::6)
 by OS3PR01MB9412.jpnprd01.prod.outlook.com (2603:1096:604:1cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Wed, 29 May
 2024 13:07:45 +0000
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::1bc:6d4b:6770:82c9]) by TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::1bc:6d4b:6770:82c9%3]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 13:07:45 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "Sai.Sathujoda@toshiba-tsip.com" <Sai.Sathujoda@toshiba-tsip.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: Request for updating device dictionaries
Thread-Topic: Request for updating device dictionaries
Thread-Index: 
 AdqmtLnvothy4nUKQBSdfu8qbwxdbQD6sUBwADL8pYAAAIHQ4ABsGuiAACP4ZqAA3sUFkAAKdJigAAOXNVAAGWcK0A==
Date: Wed, 29 May 2024 13:07:44 +0000
Message-ID: 
 <TYWPR01MB11862CCF5920E8D2C70C72ED3B7F22@TYWPR01MB11862.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103AFC364EE1AD1A9C0C81AC2EC2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <OS3PR01MB6103F00964E26A0F5D38A8ECC2E92@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYWPR01MB11862221FADD6EE25E032DADBB7EA2@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <OS3PR01MB610353B51E2D66C802A5104DC2EA2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYWPR01MB1186210AA7A8F762825C4BD44B7F42@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <OS3PR01MB6103B95D6D38ECAB1BE70F18C2F52@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <OS3PR01MB6103AF590A9C795BD550C65BC2F12@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYWPR01MB11862B2E811EE59BBC4A0CCA0B7F12@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <OS3PR01MB61036314A0787E645985735AC2F22@OS3PR01MB6103.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB61036314A0787E645985735AC2F22@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11862:EE_|OS3PR01MB9412:EE_
x-ms-office365-filtering-correlation-id: 059ffde4-9854-4f85-9750-08dc7fe054a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?a2FLMUFxNllEYWNNZDZSd2Vqc2N3QTAzNXRaUHNab2FrbU52UzN1MTdj?=
 =?iso-2022-jp?B?K0tRUFNud01VV1FGUytTS3FtUDR0eWtFYUc1akFpQWJPaW8rUW84UGlQ?=
 =?iso-2022-jp?B?WGlaUVkrRWdpNG4wcGpmYmh4TjlTSitlak13T0NuTXYrSzZZa2l3YlUv?=
 =?iso-2022-jp?B?cFA3SXo0dzJSRG9XL2VBNFBaVUtsL3JUdGs3NjVuVWd4R0Npc1UrWUJV?=
 =?iso-2022-jp?B?MFBRV255TzdOd3pCTnVqYjF4Ujd3WGhtZGRRYWMwUlEvVEtoZU9SMStG?=
 =?iso-2022-jp?B?RlZHRU9jZURlWnhxUWpvRnpxNDY3cm5aOFNsWWcwNDUrTmgvWEZQbkNn?=
 =?iso-2022-jp?B?UVFGQkVybDJRbTFrN3p4VzVNdWtyYUR2MmNCdm1tTzNZUTRMamxRa2hr?=
 =?iso-2022-jp?B?dVVHelI2RTR2aXBUU2hBVEhwZHh2bW9VUk0xNVhERnNLbHhLQkpFZThE?=
 =?iso-2022-jp?B?ckQ4bkt2anFZVHJWZ3JaZzlnR3NRaytwSUpBY1BkcjVLMjFhUXlPZ2wv?=
 =?iso-2022-jp?B?UktscVh4M1NnV2tMcWdTK1QvZ0EwQVd4UjBSUnVEbHVkaUkwOFhMWDJZ?=
 =?iso-2022-jp?B?dCt5VlpVUWIvRFo3eDNENGdsTS9rWmtsSFNCWHZrZStTNlZhT2o2c0pK?=
 =?iso-2022-jp?B?d1VLWHYxb2d3UWY2RW5wYXh3ZkdvV0I1ZjhPNFFoeHNRdUpTZDZnRUlD?=
 =?iso-2022-jp?B?dFJmaDMxaTlYTkhWZFdzUDN1VHA0MFBWTUJJOWkyZDFmeVpUcmNVRnkr?=
 =?iso-2022-jp?B?d283MDZZY05ISzRqMHdEM0U1VHFzeTFPMEl5RzBmRDV4TWlRclpVMFZX?=
 =?iso-2022-jp?B?NVNhTERlMGFIcUZVSzUzK2ZURGQ1VEUvN1IvMVRvb1l2SHEwV3VTSDY4?=
 =?iso-2022-jp?B?T3pBZmtrQ2Q4UkhRU3J3VTBTZjBsNHpCTUxFa3hsTVYrRHVHdnQyZkJV?=
 =?iso-2022-jp?B?MGs4Qlg2OC93VzBiRC9tQmJtQUhDVkFIWUl5OGZSeSt2N0p2U0lGK00x?=
 =?iso-2022-jp?B?ckdFWWp5WmxPSG91MTRVYnRIWHdUbUsxZ3V4TFRZeG82UWt4RGJyVDJV?=
 =?iso-2022-jp?B?QnNxQ2t4NjlEQXV4Q1JQYjJFZjVTUXc1OUQ1c3R3a1BGRk1MOEs2MVRx?=
 =?iso-2022-jp?B?aTNvUlRTNCtuVWNhRUJoVmVNTnFvLzFYc1RCbk9MblFsYVIrdXpLSmRE?=
 =?iso-2022-jp?B?R2ZieXhnSk52SGlvT0ZEWFpsaU5scG5vVnJKM3lXdUZ1Vm9tT2ZhMXMz?=
 =?iso-2022-jp?B?dWVZSG40WERjQWg4djJBRkdwcEdaREh0VDhRbGNzeDkraUVaOTFHUDM1?=
 =?iso-2022-jp?B?eTNDNzFHS20zeldGUFpyT01WaUVmYTBkUjg2VnVDMXhUdkRZVGNRWmVD?=
 =?iso-2022-jp?B?eGtXdWUxcER5N2hrR3Z5TkQxcXVVaTh3V0ZpV25jTVZYVHl0TXNMSE8y?=
 =?iso-2022-jp?B?aTZLTlBOYWIzcVZoRDlaN0tCeUo2WUJtYlVBNzV4TzR3RWNIY3JzSXR1?=
 =?iso-2022-jp?B?RUlGWG55NGN1NXNwc2JnVXRYSHJFWG9PZFpFdEFzclA3M2crU0h5RTRh?=
 =?iso-2022-jp?B?b1hQd2libzlZZjd5QXZPRTJDZTU2aS9adEN0Szlzd1paRDhYZlZLTUFn?=
 =?iso-2022-jp?B?amt5by83bnlRcXl2NUFqVWZVdVN2ZlY2OGFKc0xVMDJ5ZEFtWWFLSmFI?=
 =?iso-2022-jp?B?L0xsS0ZLYTlxYlUvSDJ0ekxQelpJWVVmRFAxV2hSMG9KSW5qMVVzZE1y?=
 =?iso-2022-jp?B?MXBlNE1EdC9GVGIzQkQrRzRaUXJsbUYvdndrOTFycVVlQndUTlRkNXFZ?=
 =?iso-2022-jp?B?YXByNi8za0ZvbGFkaUY5SURrVFltYVdDRFJlRVlSTjJjb0RabkZHb0R3?=
 =?iso-2022-jp?B?PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11862.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?QmdyRUtjeklxc29HZ3FyYktFM0d3bDBYY3o4RTQzeDl5MkVzSzUzL0lt?=
 =?iso-2022-jp?B?WFhZZzJ4SCtzRWtnSmRZSU95T2ZEeVh6L2M4aUZJQ2JHVEFPaXp4MUVK?=
 =?iso-2022-jp?B?V2E0cHFINDVtRVdDWU5FUFBJNmk0eGVXdS9OS2hoUlFJTGs0MlEzWGRz?=
 =?iso-2022-jp?B?dWZNYkhXaURDUk95blVmdWt0YU5xTWV3Q3hUVE9aYWZOT2NGRkh5NEE2?=
 =?iso-2022-jp?B?Wkc0M0gzK0NHV3lOblZqamtHV3ZFT2djUzQzaEpVKzl2eFNZenN4cTkw?=
 =?iso-2022-jp?B?SEhvdEt3YXBJcnZtSWFlMGo2NHNvZktOdGM5SDU5WG9wckJCV0p5ZlRD?=
 =?iso-2022-jp?B?d0RWKzNMQW9ObCs5SXVmMDRnV0RiaGlTYWxEYnhKQTZrTHRta1ZQeU9u?=
 =?iso-2022-jp?B?MHdLWVZGa2J3RWFIQ2pibDNubmtBQ2ErcFBNTExzdDA2cTN6Nmx1M0Fj?=
 =?iso-2022-jp?B?dVBlQm9mRVFoMXhzSUMyYnZlaUxaNFdwMnhkWFBibTFjWS9sQnFhNjZX?=
 =?iso-2022-jp?B?dGM0V2FFbU1QQmc4VVAyRnZZek9qcnRlb3BzbGFpZzUrN2ZUYjVqRkVm?=
 =?iso-2022-jp?B?U3ZMVDNocWZmSU9rRDNHTm5RTS9GZ3JKNUxEMzIwSDhHa21QdE42YUFH?=
 =?iso-2022-jp?B?OE9PQ0p4QlJscXJCUHo5WkRHOXUwWG5oNEtiYXZ5SVRtTDVSYW9YdVVL?=
 =?iso-2022-jp?B?NmZxaHFTV3VzV3hHTjRubnlUU2ZmWjNZNWk4YkRSa1B0WVlZUlE5ZUpW?=
 =?iso-2022-jp?B?UFZoZnRDY2x0dXBRMkRTSG85Mk84ZzQ1OURWQlY3c0FGRVZ1dkVrVXV0?=
 =?iso-2022-jp?B?UzZscFpuVUVPYVA1QjlVQlVFUnU1VW5Majk4M3VIZDluc2xacUQvWnR6?=
 =?iso-2022-jp?B?S2VKVEZPR3pNTmV4bjdNU0dadG9DbUdoQ2hTem1IaEtLZXNiL0doQTNN?=
 =?iso-2022-jp?B?TFEvZExWR3pxN3BNcnlrci9XOGZHQ2pmaGFiWmxOcENRM0JENXBrK0Zk?=
 =?iso-2022-jp?B?UWVUYk01QWhTMERZRmlWYkpwUFF4cTltN1MzT2lKZXRkV2ltOVUzZ0ZQ?=
 =?iso-2022-jp?B?blkvbCtDTHFKM1kwcnlLRUVTYXJyN3c1eVJtcGF1YXVDcVlTZTA2eFB0?=
 =?iso-2022-jp?B?cFRQUjRoRmZoMy9hOXVqYlI1VnZ4eXE5cVBHSU5UQm5Gd0NjbmVYdCty?=
 =?iso-2022-jp?B?Y1FnejdQWDRTVmduWk9qcGtQZk53YW11enYvcDZOUDhrN0gvb3FzY2NK?=
 =?iso-2022-jp?B?eDZWc01NSExVQTVDSlpGMW5jNU9IUHZtbUJseVlqYjJXQVZsWk9KOS9R?=
 =?iso-2022-jp?B?MU5Lbk1QSXRTZlFqdEJ0SE9nRUZieUtZUk9oYXY5SHYyVDhBeXpaRTJX?=
 =?iso-2022-jp?B?MGYveVVPMzJOckFScVRDL0tqS2Z4a3B0bll1aWZVdm5KeVMzK2ptQnVF?=
 =?iso-2022-jp?B?b1ovWldzSXhRalI3K0tmaHBEZFY1ZHlmREQ0dFZNUmJBQUNBRFVhZzJl?=
 =?iso-2022-jp?B?K3BZZzlKUy9Cc2djY2lYTnZvclRhTXo0ZFl5RVBWWHZxakdRMlVxRHVk?=
 =?iso-2022-jp?B?cjZjNVdXdTV2R1ZwMGE5ZldSU096QXpoZk1SK0w2VVNKT3l5NUZ5Q0lm?=
 =?iso-2022-jp?B?dWFQTWxIQkJHYWxnaFYzbUFxTTFTUDFiSlVjeGZScDloNGZ0QWFsdkMz?=
 =?iso-2022-jp?B?VFR4OWdsS3huNUxMT1BQRmI2OFpROEY4L3VHYWZJbUs5L09PUmhRWEZE?=
 =?iso-2022-jp?B?dElwd0xDZExQYmRxR2V1b2F6Z2laZ0o1bmsrZlZPQU9qSXFHNng5ZXI1?=
 =?iso-2022-jp?B?bUpCSk0wSzJwZ1czNDRnN0hZdXNPV3pSaEZSYnp0NnJ4eDJ4REYzaG14?=
 =?iso-2022-jp?B?Vk1USlloTVVjdytEUW84aEhycDBlWHh4c1JOMWdwMmUzSFFEZ0g5d2du?=
 =?iso-2022-jp?B?MXhINlRxQnV1Q0JsTUpReG5UL3kvcU1lSnZybmFqaHhlMXNGZitIVStP?=
 =?iso-2022-jp?B?a2RENGdUYkk1SWIrRlROY0w5a1VkSkFROGMrd3dHSWhwL3ZNL2lhNE5F?=
 =?iso-2022-jp?B?VEhEd0RNcUltQ05HNmFuR1crdzAraEpMcERhRTZmbGtFYnVwTS9QcW9v?=
 =?iso-2022-jp?B?MnRMQ0tPb2FqQUhoZTFVcjI3WlFpbFpNaGdHYzdoUzM2ZVErMXBFbENY?=
 =?iso-2022-jp?B?VXAzRTlldjJJczd1aXA0aHJYV3RwZTgxZGUwZWJrd3QyeXRKSkJMYWxn?=
 =?iso-2022-jp?B?Z2N0SDA0RDJlZ2tkeGtJRXhObUlpM2wzajV3dVdvandaQnNVNXh3WVNW?=
 =?iso-2022-jp?B?RnBuQlhjWlhRRitTb1lHcDNkVzBGYlc3aVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11862.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 059ffde4-9854-4f85-9750-08dc7fe054a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 13:07:44.8859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YWSIfKzmEs87VqAgU+uYPh/wxLWGsclNMHMSjbkNbPQBSWXDt3pyyvx+HjXIFuysjAJnMSW47KeFDXluZv6A6I+CMmlOsVqb/asU/eUsLho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9412
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 13:08:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16065

Hello Sai,

> From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>
> Sent: Wednesday, May 29, 2024 1:56 AM
>=20
> Hi Chris,
>=20
> Thanks a lot for your support. I apologize for not including changes to
> install swtpm and ovmf packages to the slaves. Thank you for creating an
> MR for that.
>=20
> I agree that we must work on this limitation that only one QEMU device
> will be able to run these jobs in each lab. The problem is if the image
> boots on a QEMU device in a lab, it acquires the below socket.
>=20
> swtpm socket -d --tpmstate dir=3D/home/######/XXXXXX/isar-cip-
> core/build/tmp/deploy/images/qemu-amd64/cip-core-image-security-cip-core-
> bookworm-qemu-amd64.swtpm --ctrl type=3Dunixio,path=3D/tmp/qemu-swtpm.soc=
k --
> tpm2.
>=20
> Then if the other QEMU device in that slave also starts booting, we will
> have some conflicts to due to which there are high chances that both the
> jobs can fail. Let me investigate on how to overcome this limitation and
> make the both the QEMU devices ready to run these swtpm related jobs.

Yes, it's a problem.
We'll also face problems when you start running this testing on non-qemu ma=
chines in addition.
I've not thought of a solution yet.

Chris

>=20
> Thanks and regards,
> Sai Ashrith Sathujoda (T S I P)
>=20
>=20
>=20
> -----Original Message-----
> From: Chris Paterson <Chris.Paterson2@renesas.com>
> Sent: Wednesday, May 29, 2024 4:43 AM
> To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>
> Cc: cip-dev@lists.cip-project.org; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9=
(=1B(B =1B$B#D#M#E=1B(B
> =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>
> Subject: RE: Request for updating device dictionaries
>=20
> Hello Sai,
>=20
> > From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>
> > Sent: Tuesday, May 28, 2024 7:23 PM
> >
> > Hi Chris,
> >
> >
> >
> > Today while I was testing isar-cip-core LAVA job trigger pipeline, I
> > noticed that the one and only device (qemu-renesas-01) which has
> > custom device dictionary changes to use swtpm related scripts to boot
> > CIP security image are gone. LAVA | Scheduler | Devices |
> > qemu-renesas-01 | dictionary (ciplatform.org)
> > <https://lava.ciplatform.org/scheduler/device/qemu-renesas-01/devicedi
> > ct> . Because of this none of the QEMU devices present will be able to
> > test Swupdate, secure boot and IEC layer.
> >
> >
> >
> > Chris, I am about to send patches to isar-cip-core to trigger LAVA jobs=
.
> > For every pipeline it must run 11 jobs on CIP LAVA QEMU devices. So, I
> > request you to please update device dictionaries of only one QEMU
> > device in each lab so that we can have 3 to 4 QEMU devices able to run
> > CIP Core jobs and this also makes test stage runs faster in
> > isar-cip-core pipelines.
> >
> >
> >
> > I have already created an MR https://gitlab.com/cip-project/cip-
> > testing/lava-docker/-/merge_requests/35 <https://gitlab.com/cip-
> > project/cip-testing/lava-docker/-/merge_requests/35>  to include
> > required scripts in all CIP LAVA workers. I mentioned the reason why
> > we need to manually update the dictionaries instead of updating the
> > dictionaries of all the available QEMU devices here
> > https://gitlab.com/cip-project/cip-
> > testing/lava-docker/-/merge_requests/35#note_1921132805
> > <https://gitlab.com/cip-project/cip-testing/lava-docker/-
> > /merge_requests/35#note_1921132805>  . Please have a look at this.
>=20
> I'm still not happy with the approach this MR is taking, but as you need
> this functionality working, I've merged it for now.
> I've created a follow up issue and assigned it to you to look at when you
> have time.
>=20
> I've also created an additional MR to add the functionality missing from
> your own (we need to add packages to the LAVA slave Dockerfile).
> This too has been merged.
>=20
> >
> >
> >
> > I request you to consider this as high priority because we are working
> > to enable this LAVA job triggers from isar-cip-core as soon as
> > possible. We will not be able to test if none of the QEMU devices are
> > able to run any of the CIP Core jobs.
>=20
> Lab-cip-renesas and lab-patersonc have both been updated to the latest
> cip-lava-docker version.
> One qemu machine from each lab should now work okay for your testing, but
> please double check for me.
>=20
> I will ask the other lab maintainers to make similar changes their end.
> Once done there will be four qemu devices available to you.
>=20
> Kind regards, Chris
>=20
> >
> >
> >
> > Thanks and regards,
> >
> > Sai Ashrith Sathujoda (T S I P)
> >
> >
> >
> > From: ashrith sai(=1B$B#T#S#I#P=1B(B)
> > Sent: Friday, May 24, 2024 1:15 PM
> > To: Chris Paterson <Chris.Paterson2@renesas.com>
> > Cc: cip-dev@lists.cip-project.org
> > Subject: RE: Request for updating device dictionaries
> >
> >
> >
> >
> >
> > Hi Chris,
> >
> >
> >
> > I updated the corresponding MR lava-slave/scripts: Add scripts needed
> > to run for booting CIP QEMU security target (!35) =1B$B!&=1B(B Merge re=
quests =1B$B!&=1B(B
> > cip- project / cip-testing / lava-docker =1B$B!&=1B(B GitLab
> > <https://gitlab.com/cip-
> > project/cip-testing/lava-docker/-
> > /merge_requests/35?commit_id=3D6642a2390ead758ecbb8b096c62c4c5d4fd504b3=
>
> >
> >
> >
> > This MR only adds the scripts in the workers. Updating device
> > dictionaries on only one QEMU device in each worker has to be done
> manually.
> >
> >
> >
> > If you have further review comments, please provide them in the MR.
> >
> >
> >
> > Thanks and regards,
> >
> > Sai Ashrith Sathujoda (T S I P)
> >
> > From: Chris Paterson <Chris.Paterson2@renesas.com
> > <mailto:Chris.Paterson2@renesas.com> >
> > Sent: Thursday, May 23, 2024 8:04 PM
> > To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com
> > <mailto:Sai.Sathujoda@toshiba-tsip.com> >
> > Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting)
> > <dinesh.kumar@toshiba-tsip.com <mailto:dinesh.kumar@toshiba-tsip.com>
> > >; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B
> > =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp
> > <mailto:kazuhiro3.hayashi@toshiba.co.jp> >; jan.kiszka@siemens.com
> > <mailto:jan.kiszka@siemens.com>
> > Subject: RE: Request for updating device dictionaries
> >
> >
> >
> > Hello Sai,
> >
> >
> >
> > I can update the device dictionaries, however each lab would need to
> > update it=1B$B!G=1B(Bs worker docker image to include the swtpm*.sh scr=
ipts.
> >
> > Before we do this, we should really finish and merge the corresponding
> MR:
> > https://gitlab.com/cip-project/cip-testing/lava-docker/-
> > /merge_requests/35/ <https://gitlab.com/cip-project/cip-testing/lava-
> > docker/-/merge_requests/35/>
> >
> > Please could you check the remaining threads?
> >
> > Once merged I=1B$B!G=1B(Bll ask for each of the workers to be upgraded =
(I only
> > have access to my own worker).
> >
> >
> >
> > I=1B$B!G=1B(Bll remove the swtpm-jobs tags I added the other day, so at=
 least
> > your pipelines don=1B$B!G=1B(Bt fail ? they=1B$B!G=1B(Bll just run slow=
er.
> >
> >
> >
> > Thanks, Chris
> >
> >
> >
> > From: Sai.Sathujoda@toshiba-tsip.com <mailto:Sai.Sathujoda@toshiba-
> > tsip.com>  <Sai.Sathujoda@toshiba-tsip.com
> > <mailto:Sai.Sathujoda@toshiba- tsip.com> >
> > Sent: Tuesday, May 21, 2024 12:05 PM
> > To: Chris Paterson <Chris.Paterson2@renesas.com
> > <mailto:Chris.Paterson2@renesas.com> >
> > Cc: dinesh.kumar@toshiba-tsip.com
> > <mailto:dinesh.kumar@toshiba-tsip.com> ;
> > kazuhiro3.hayashi@toshiba.co.jp
> > <mailto:kazuhiro3.hayashi@toshiba.co.jp> ; jan.kiszka@siemens.com
> > <mailto:jan.kiszka@siemens.com>
> > Subject: RE: Request for updating device dictionaries
> >
> >
> >
> > Hi Chris,
> >
> >
> >
> > Thank you so much for adding the tags to one qemu for each worker. But
> > the device dictionaries for these tagged devices need to be updated
> > with the below snippet. Without these changes we cannot boot the
> > security image in LAVA.
> >
> >
> >
> > {% set user_commands =3D {'start_tpm': {'do':'"/usr/bin/sh
> > /usr/local/bin/swtpm_start.sh"',
> >
> >
> >
> >                                       'undo':'"/usr/bin/sh
> > /usr/local/bin/swtpm_finish.sh"' },
> >
> >
> >
> >                         'manual_kill': {'do':'"/usr/bin/pkill -15
> > swtpm"'}} %}
> >
> >
> >
> > Just like it is updated for this device LAVA | Scheduler | Devices |
> > qemu-
> > renesas-01 | dictionary (ciplatform.org)
> > <https://lava.ciplatform.org/scheduler/device/qemu-renesas-01/devicedi
> > ct>
> > .
> >
> >
> >
> > Can you kindly update the device dictionaries for the below =1B$B!H=1B(=
Bswtpm-jobs=1B$B!I=1B(B
> > tagged devices ?
> >
> >
> >
> > *	https://lava.ciplatform.org/scheduler/device/qemu-03
> > *	https://lava.ciplatform.org/scheduler/device/qemu-cip-siemens-muc
> > *	https://lava.ciplatform.org/scheduler/device/qemu-patersonc-01
> >
> >
> >
> > I will contact the maintainers of isar-cip-core project regarding
> > CI/CD variables.
> >
> >
> >
> > Thanks and regards,
> >
> > Sai Ashrith Sathujoda (T S I P)
> >
> >
> >
> >
> >
> >
> >
> > From: Chris Paterson <Chris.Paterson2@renesas.com
> > <mailto:Chris.Paterson2@renesas.com> >
> > Sent: Tuesday, May 21, 2024 4:24 PM
> > To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com
> > <mailto:Sai.Sathujoda@toshiba-tsip.com> >
> > Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting)
> > <dinesh.kumar@toshiba-tsip.com <mailto:dinesh.kumar@toshiba-tsip.com>
> > >; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B
> > =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp
> > <mailto:kazuhiro3.hayashi@toshiba.co.jp> >; jan.kiszka@siemens.com
> > <mailto:jan.kiszka@siemens.com>
> > Subject: RE: Request for updating device dictionaries
> >
> >
> >
> > Hello Sai,
> >
> >
> >
> > You need to talk to the maintainers of the isar-cip-core project to
> > get CI/CD variables set there. It=1B$B!G=1B(Bs not my project so I shou=
ldn=1B$B!G=1B(Bt make
> > such changes.
> >
> >
> >
> > I=1B$B!G=1B(Bve added the swtpm-jobs tag to one qemu from each worker. =
Check the
> > =1B$B!H=1B(Bgreen eye=1B$B!I=1B(B on the right of this page:
> > https://lava.ciplatform.org/scheduler/device_type/qemu
> > <https://lava.ciplatform.org/scheduler/device_type/qemu>
> >
> >
> >
> > Kind regards, Chris
> >
> >
> >
> > From: Sai.Sathujoda@toshiba-tsip.com <mailto:Sai.Sathujoda@toshiba-
> > tsip.com>  <Sai.Sathujoda@toshiba-tsip.com
> > <mailto:Sai.Sathujoda@toshiba- tsip.com> >
> > Sent: Monday, May 20, 2024 11:23 AM
> > To: Chris Paterson <Chris.Paterson2@renesas.com
> > <mailto:Chris.Paterson2@renesas.com> >
> > Cc: cip-dev@lists.cip-project.org
> > <mailto:cip-dev@lists.cip-project.org> ; dinesh.kumar@toshiba-tsip.com
> > <mailto:dinesh.kumar@toshiba-tsip.com> ;
> > kazuhiro3.hayashi@toshiba.co.jp
> > <mailto:kazuhiro3.hayashi@toshiba.co.jp>
> > Subject: RE: Request for updating device dictionaries
> >
> >
> >
> > Hello Chris,
> >
> >
> >
> > Any updates on 2nd and 3rd requests I made in the below mail ?
> >
> >
> >
> > Thanks and regards,
> >
> > Sai Ashrith Sathujoda (T S I P)
> >
> >
> >
> > From: ashrith sai(=1B$B#T#S#I#P=1B(B)
> > Sent: Wednesday, May 15, 2024 4:41 PM
> > To: Chris Paterson <Chris.Paterson2@renesas.com
> > <mailto:Chris.Paterson2@renesas.com> >
> > Cc: cip-dev@lists.cip-project.org
> > <mailto:cip-dev@lists.cip-project.org> ; dinesh kumar(=1B$B#T#S#I#P=1B(=
B TMIEC ODG
> > Porting) <dinesh.kumar@toshiba-tsip.com
> > <mailto:dinesh.kumar@toshiba-tsip.com> >; hayashi kazuhiro(=1B$BNS=1B(B=
 =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B
> > =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp
> > <mailto:kazuhiro3.hayashi@toshiba.co.jp> >
> > Subject: Request for updating device dictionaries
> >
> >
> >
> > Hello Chris,
> >
> >
> >
> > Hope you are doing well.
> >
> >
> >
> > Sorry to disturb you with these extra things I need on CIP LAVA Lab.
> > Let me consolidate my requests in this mail.
> >
> >
> >
> > I am preparing a patch to trigger LAVA job definitions from isar-cip-
> core.
> > Currently I am working on that in a custom branch. Before sending that
> > patch, I have created an MR to update the cip-core-ci repository which
> > is required to run the test jobs in isar-cip-core. I will assign it
> > for your review soon.
> >
> >
> >
> > I will be able to send the patch to add test jobs in isar-cip-core
> > once the below mentioned things are done.
> >
> > 1.	This MR needs to merge build-bookworm.Dockerfile: Include lava.sh
> > and templates in the docker image. (!3) =1B$B!&=1B(B Merge requests =1B=
$B!&=1B(B
> > cip-playground / cip-core-ci =1B$B!&=1B(B GitLab
> > <https://gitlab.com/cip-playground/cip-core-ci/-
> > /merge_requests/3>  which I shall assign to you soon after some
> > internal review.
> > 2.	I need some variables in isar-cip-core CI/CD setting section like
> > LAVA_USER, LAVA_TOKEN and SQUAD_TOKEN. We don=1B$B!G=1B(Bt have the pri=
vilege to
> > do that. I will mail them to you personally. Please hide them in
> > isar-cip- core Gitlab CI/CD section so that I can use them while
> > running lava.sh script.
> > 3.	Since we need to run these LAVA jobs when pipelines are triggered in
> > isar-cip-core, I am making changes in such a way that pipeline keeps
> > running until all the jobs are done and we report the health as a
> result.
> > It will take around 120 mins to run all the jobs. We have only device
> > (qemu-renesa-01) under lab-cip-renesas. So, I request you to please
> > add the swtpm device dictionary changes and swtpm-jobs tag to only one
> > QEMU device in every LAVA lab you can access. By this will be able to
> > reduce the pipeline run-time due to simultaneous runs.
> >
> >
> >
> > It will be very helpful if you provide your support with the above-
> > mentioned items.
> >
> >
> >
> > Thanks and regards,
> >
> > Sai Ashrith Sathujoda (T S I P)
>=20


