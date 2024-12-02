Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A972D7831F
	for <webhook@archiver.kernel.org>; Mon,  2 Dec 2024 13:30:19 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.173756.1733146214266750384
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Dec 2024 05:30:14 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 4B2DUCfm1919791; Mon, 2 Dec 2024 22:30:12 +0900
X-Iguazu-Qid: 2yAaJ6GC3IY91B7BoW
X-Iguazu-QSIG: v=2; s=0; t=1733146212; q=2yAaJ6GC3IY91B7BoW; m=FzTwH2ZqPDBKDoSzPLgshCNISvwg2akiA6iqQe/UcWg=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 4B2DUAG22832472
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 2 Dec 2024 22:30:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JcE9BcrSU4o31vv1QzsV084joy2TGtYl3CyxTWaRCuNGrVQARIBUYyaCOJA7/ZGIVRNM9nri11/tMkOYnx5u+F4Fy5x3XH/8ksOEYlSQLKgnh/5uZZlEjvofKRESkEZ7d+Pp7VSTWdoh1D1LXCzS2Aq7hMt2zc+w7ORq36j5dZ00UujmEoyWSRL5Tr2WpNSF2ytSfPxayiJjhWiIr4vEiwG6LC7d/TQeQDfGZEmBTchoD68J+H36UPkggJFGq2GvWaF/pP0TShhlOKyaFbIYWcZG1B6GHUNWfrE68indPRFUeMCvi49bkaBvuxky5SG8ZkxNUwk6KJuYXcuvRPx4Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woQZB3nv6ga5vw1VhniPsk5c7C8x15zFZPNVbaOiCmo=;
 b=feUsF6ov1DCEq91+vkb38XworZkVQMG/+M49D8+vwf0qokPpQSirgr3XHfgc+WnF2YN+ZUP46Obi+jFl7js1NX2ytAC3iDHc28QQ5vOjslwVest5Vg2yCHVOPi1ifz6o10B8AkjFhA+Scg3OhxKI8CZkDo+/R8FKcsEF6mHAs1wmwSHYkG7o3/AkaKqCC5qSSV9YRy6brt46gXWJyFQxzk2uqytrJcgymkTar+jbT5+HJ+1IolKmVyHCeouGAlkrSsnF8tD/wpFr6It2GfdqAFwE07dVsFQ+J796PQaNVMU0J6Rb/sLjtehBpD5y5TMo6VQXiIyix3fg6HeH6GSrEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <kazuhiro3.hayashi@toshiba.co.jp>, <cip-dev@lists.cip-project.org>
Subject: Re: Booting security image (.wic) on M-COM x86 in LAVA
Thread-Topic: Booting security image (.wic) on M-COM x86 in LAVA
Thread-Index: AQHbQLwTUaTAYoFsNEu+W9FEgwfyArLLAK5wgAf2zdk=
Date: Mon, 2 Dec 2024 13:30:08 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6100DDA81973DC6533408914C2352@OS0PR01MB6100.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103FB47A8576B2CFA3275F6C2282@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYYPR01MB1240202744B87D2E939DAD687B7282@TYYPR01MB12402.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYYPR01MB1240202744B87D2E939DAD687B7282@TYYPR01MB12402.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6100:EE_|TYAPR01MB5883:EE_
x-ms-office365-filtering-correlation-id: 28f6d20b-a770-48e9-ce74-08dd12d57080
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|8096899003|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?WUk5V1BkRW5YMVJnN3NDQUVkeFB3M3Uyb2hsRWhKd1FwR2NWbVQ1UWlu?=
 =?iso-2022-jp?B?VVFhcW5LdUVwcEkreCsyZ0g2TnNmTVU1K0I2dEI3K0xwYnd6S3VKTi9L?=
 =?iso-2022-jp?B?NnBvVVU5MTBKbU4rQ0hmWVIyTGkwa1RUamxuVEtjakhmRkZ2b2JSMmkr?=
 =?iso-2022-jp?B?MmRyazdudThaMGYrOGVwMkloeXN3UHp5c291dEhnWFZ3dmVzcXdpcmxk?=
 =?iso-2022-jp?B?Z3FhVytKeVNsc2c0N3JqU0VUZmIxOUpKUS9MZlphdWtQT2NWNEZCcXAv?=
 =?iso-2022-jp?B?WXlwejV3Z1NVZEJENDgveHBqVXcwbUl0MmVBdUp5QW8yMUJRMjV6UmM2?=
 =?iso-2022-jp?B?cUl4ZWU2MytyUUsrejM4WDVmem1xQ1dLenQ2TTRqbkI3N3pDYlVabVZ4?=
 =?iso-2022-jp?B?N0Z5OTdnOFJnbVhFa0tYT0RxSSs2WitzU0J3bTI4dkVQb3gxMzYreDh1?=
 =?iso-2022-jp?B?REpidW5BWVlYb2N0R0VUUDAvQWJpb2FHaC9QVTN3dzM5TktVVUpnQXM0?=
 =?iso-2022-jp?B?bk5UV01jOWFnOHl1ZFpZQlBnSDJxaGNrckM4cGFPY01aTHp5ZzluL08y?=
 =?iso-2022-jp?B?aVVQcnN6ZTU1SzVqWXZCMmJlUmc3R0sxeGdKaFZDeHRXc0tWNHBvZHhv?=
 =?iso-2022-jp?B?aE5jTTZvNnJqbzllQmxxY0h1ZElKb3JxTXpwbHE3ZTVTQ25TOHIxOVli?=
 =?iso-2022-jp?B?K3VPSU5EU1BzVWIvV0tPMjlxdXp2Y2EzV0RVTEcrSHlKRk5Bc08xa0Ju?=
 =?iso-2022-jp?B?VThuZjlsL2kvSzRDSXN3ZU1WT1hMMWQ1Z2kreUZVTlJLM0JzSUxNQVhW?=
 =?iso-2022-jp?B?U3VMQWVqUUpMYzhYcGJpcWUwZHM5VXNSOEtvWjIyVTZTbzdMRlFkNzhR?=
 =?iso-2022-jp?B?eUlxblB2L3VneWR6OUxEa0I0MllnQmdZajV3MDJzMnFsOTd0V1htWUdw?=
 =?iso-2022-jp?B?eGtBZVJXY3NsTnBVdVdkejl4empqUkF4UFNkVmVML05tYzJ5SmllN3kv?=
 =?iso-2022-jp?B?cTRHYjZSREZjOUtlcWZ1NW9EajZzK1ZUR2E2Y3FOQXJwYlRZSlQ3N1Vi?=
 =?iso-2022-jp?B?OGNhTXN2OEdiUWs2UkpMSlA4dWVWOUgvZ3IrWDJHR0xiZDdlMjlJRnhS?=
 =?iso-2022-jp?B?OWRST3ZhWEF3eGgvUWluNzJIMEdWd1lFTG5FdWdFMjBhUklVM2J6QXlP?=
 =?iso-2022-jp?B?dWV5L0RyYTZZNVE3d01MdG1vV3Y2a0pxckxydTQ4WnNQUk05bklCdVAv?=
 =?iso-2022-jp?B?NXRMSVRFTXVlQk5oYVBIT0lOdUhTYmtoemJqZ1dsc2d6YmNyNzZrK0ZK?=
 =?iso-2022-jp?B?TE1rblhlc0QveU9YN0UySVRxazdWZG5zVEY0ZkFWWUZrcllrc2VoTnJo?=
 =?iso-2022-jp?B?N1pMUVFNelZrMFYxMGFHVGNYVU1PSHFPS0pFeVJrNVdzZm1PNDRwQnZL?=
 =?iso-2022-jp?B?YzBNZXV3bVc0T1Nzb2FrNnE1T2ExTDA2WDNFWWhYVkJhTWtvZGI4TVdQ?=
 =?iso-2022-jp?B?WXowdUROa2NGYnk4UVpRZ3ZIaHQ0Y04vKzRxUGI0K2grZHNSVlFRTHFi?=
 =?iso-2022-jp?B?bExGZEI1NWNUcFJFdVNnVW9tbnBwbE5iM3E4MkRaT2w4ajBFYk1zSnhJ?=
 =?iso-2022-jp?B?OUxTTXYxOS9Pb25YSlZzcFhzQ1RxVVZ6cUd2T042S0tpOGliQ3A5Z0tr?=
 =?iso-2022-jp?B?ZGd0eHdBU2dIdWgvYkh6VUtSM3JwcXliZ1JEUzQ1Szh0a0IvZkZzWU9O?=
 =?iso-2022-jp?B?Z1ZIWmxPSlkxYXc0U3VsZXpkZ0lwZTZkT3hqNUIyS2tNMkc2ZFVma0c3?=
 =?iso-2022-jp?B?QmpFQzFwb1FnNWFWZEtBVEpNSlR6SUpLVEc5WGthN25XamQwQXRGTFlv?=
 =?iso-2022-jp?B?YSswTGVycU00ME16a1VNZ0RzTE1HNVVCamFVd0JKV0pWSVB0MzhWV3ZL?=
 =?iso-2022-jp?B?QytzL1VxeEhCcS9XKzhiL2ZjR1d6cUNISzZYVGpKdERJS1ZFK29HeWpn?=
 =?iso-2022-jp?B?MD0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6100.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(8096899003)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?SG9BcUJLZEtkMnp6TXJCMFd4VWJhdXZoVzRaV1BXYnpLMUlIdDRudHJM?=
 =?iso-2022-jp?B?SlViMis3OXpUQzJpSmlNL1JsaWY3bkxyc1pHTE5aUGJ1V29FREIreVNy?=
 =?iso-2022-jp?B?T3doMDVPZEorUTVrWlIrZWNJZm1Bc2NhUklzVGg1THV3ck0yU1lmeGx4?=
 =?iso-2022-jp?B?SXAvVjIxdUhDS1NkRThFMGdZdEV1TldlREZzN3NZUFh1QkhHdnl6Umpr?=
 =?iso-2022-jp?B?aHBraFBveFVWZVJhR21jWDk4Y0M5Q2Y5V3NIc2VEMWtmVmwvQ0tyNmE3?=
 =?iso-2022-jp?B?RXBTaEluQ0hQSEFWTGJPZVQ3aktSQUJIMERnbzNtYkRsbzNKdE15K2Vi?=
 =?iso-2022-jp?B?R1c4WXRHb25JckE1MEFEUzlJZjlTNlloY1JTM29mYjEweWQ2TnlOT2lW?=
 =?iso-2022-jp?B?Z282T0pUdUhmTi85Wmt2bll3d0JhVHBHditSL25UV0VkaENmanlteEFJ?=
 =?iso-2022-jp?B?QUh6a3h1MFBqbndqQTUzSldMQ28vcWlWR2JRSFp4TDlpMEdQajVBckRp?=
 =?iso-2022-jp?B?b3p0QjFnNHNCS2llVmRrRVV4ZHlCR2JTVitERkNaUzlRYm1seE84ejhv?=
 =?iso-2022-jp?B?MVBvbEZ5eElWRDFENnFIbDZuR3NNU0ZDejVZempuQ2cyb05LSWYxZGRQ?=
 =?iso-2022-jp?B?dXptV24vR0RPcFZCSk9lL3EvNk9tdWhBNGplaEdOdGVJYUgydkJtVVF2?=
 =?iso-2022-jp?B?MUNJVmdxZVZINlZkTE5UbFg3NGE4QlJJMzJxMVlEc1VkbEF3RFlCT1Fz?=
 =?iso-2022-jp?B?MnFjUjQvTGZtb0I3YjRjdllyVEUycUN2Y1hZeTM5eEkwZWZKRVdvTVhZ?=
 =?iso-2022-jp?B?L09CdW43TzVxWFB0TXpxRUZZRkJaZUhWZ0UwK05VeHlSMVVzTVY2cmt1?=
 =?iso-2022-jp?B?S2VpMU52NDAzL2pMV0RacHVlOWRVanVScWpmRkoyT1o3U0JUYnVzZUo2?=
 =?iso-2022-jp?B?NDhJWk5RckdPVmlKMXc5dFc1d3N2SWJCUFZiTS9EOU1YNVNaQkFxdjda?=
 =?iso-2022-jp?B?RkRoUFFCUTlPNVYrenVBNHZEeVF0OU9jQ0dkOE5ZSllQVHArdmdjVXdJ?=
 =?iso-2022-jp?B?ZkNHNHlVYncySTBGUm92azNQWU1BS1FheGR5YmZuOFZuQ24vU1BKR2px?=
 =?iso-2022-jp?B?Z1B0Y3dVTE8wYXpNVnlFOTB1MVRCNHVDck8zMHcySFFaNENqbmMzc1dy?=
 =?iso-2022-jp?B?cEM3a2lDVnRhODFYWTgxd2NkZTdaTHlRZVFNbjlXb0VRU3FCQVBIYjZS?=
 =?iso-2022-jp?B?QXJOQnhuVEwyOG14ZzJua2RJY0pwamh5eitwWDlCUnQ2NzNaNXdBWUxD?=
 =?iso-2022-jp?B?RTFTS0lQM3YxK01maytCSGRWekpnRmZJYXBWZnBtZER1WmFSejdLSzRE?=
 =?iso-2022-jp?B?WTVsS1hNSWYvWTJzaFhJWE9ndlRmKy96OUtTb3ZrN3p1NXRiS0pmeG4x?=
 =?iso-2022-jp?B?RlF2NFlmaVFUWWhRTWRNbTFvQ3FXUUhnOVRWcFlaa2JDM1BJY3dnVEJG?=
 =?iso-2022-jp?B?ZHJRbDd0UExQRGNiTm14TlhpUlVHNFlWTXIrWDBGTjhtMk9xRnZUcTMz?=
 =?iso-2022-jp?B?dUFPQlVpRGFtbXpiK0J3UENwU0FDOVZpOU1jdW9KcGFRTWV3LzdKK3Iy?=
 =?iso-2022-jp?B?N3V2NmpNVmlocWJHZFdVczlIam1qaURGT2J5THIxRlY2VzdsbWZzWk5W?=
 =?iso-2022-jp?B?R3BDYUFpOS9RRGsycFFCcGRZRUxXZm8wZEJHcU5xNG4rdlNJQkVIcCtT?=
 =?iso-2022-jp?B?ZEs2bkljNHI4b3hlS3ZPWnA2VXVvU1pXZzhoZDZWem8vc3dSaVhzUita?=
 =?iso-2022-jp?B?Q0wvZUNRK2hqd3l6S0NDZ280RHhyMmNIZjFKRHhzVThQK2JMZHpDQldk?=
 =?iso-2022-jp?B?SWk4VVhUU3d1enZobXFYQWw2N1VLS2YrMmRNNVNaYjFQS2kxY1prN1NW?=
 =?iso-2022-jp?B?K0t5bk9GcUVwU1E0SVV1QkRxYUlDMERIY3dtd2hiMkhGMHVDOElabzIv?=
 =?iso-2022-jp?B?anlNQ2ZlZHgrNnM4V1gvdTdSaGIyeTM4Nnh0bmM0NWpwOGs5NklQV0lZ?=
 =?iso-2022-jp?B?TW9ESlF0eVpkRDFLd054dEgrNmZQbEF6T1JKbWZKbzgyMG1YeElRS0o4?=
 =?iso-2022-jp?B?VE40MjdGTVlGbG8ydWtRS2RzYXc1dUM5TmR3T212aUQ2blNqejFaM3FY?=
 =?iso-2022-jp?B?dlNiZUwyMXBKUS9IdGZmSzVlbXpNUjM5N2ZBYnNIKzhoS2dYcG1iY0dX?=
 =?iso-2022-jp?B?Y1ArY3duNFl4R24yMlMxM3plejlUd2pnOWp4RGV1OFVaWDYyUGs1UEl5?=
 =?iso-2022-jp?B?TVdyL04xS3lqSXREOXNDTVdzQWx3dkxTTXNQcjhwWjcyV0N5d3V1c3E5?=
 =?iso-2022-jp?B?L2Flc3J5YjRtdm5UYnFWajB3OExlQnJiejU3dHlMQWZWT0JWeFZrYWZ6?=
 =?iso-2022-jp?B?TVNvbnJnPT0=?=
Content-Type: multipart/alternative;
	boundary="_000_OS0PR01MB6100DDA81973DC6533408914C2352OS0PR01MB6100jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6100.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f6d20b-a770-48e9-ce74-08dd12d57080
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2024 13:30:08.0763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ybo9S44nRtkV+kL/isvJq5phm4kZnfl5XelwYp/khFiMf+bTBm0OaVh7m0kLNoXKlzK9QyyompcyxRsH4up6zmBOJDomawwU7rXE+W/YrBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5883
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Dec 2024 13:30:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17306

--_000_OS0PR01MB6100DDA81973DC6533408914C2352OS0PR01MB6100jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Chris,

As of now, we think flashing to USB and booting from it can be one option a=
s I did not find any eMMC deployment methods in the documentation. Need to =
check this further.

As you said I saw similar discussions in lava users mailing list where they=
 suggested to first boot into a normal system and then flash the wic image =
into some sort of permanent storage and then rebooting the device to boot f=
rom newly flashed storage. I will go through those discussions to see if we=
 can get any leads.

By this statement "We could duplicate the amount of hardware so that we hav=
e some permanently configured in secure boot mode, and some in "normal" boo=
t mode.",  I believe you are referring to multiple M-COM x86 devices connec=
ted LAVA Lab, but I am not sure about that.

Thanks and regards,
Sai Ashrith



________________________________
From: Chris Paterson <Chris.Paterson2@renesas.com>
Sent: Wednesday, November 27, 2024 6:28 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>
Cc: hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D=
#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>; cip-dev@lists=
.cip-project.org <cip-dev@lists.cip-project.org>
Subject: RE: Booting security image (.wic) on M-COM x86 in LAVA

Hello Sai,

> From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>
> Sent: 27 November 2024 11:08
>
> Hello Chris,
>
> We are planning to run software update, secure boot verification and IEC
> layer tests on M-COM x86 device in CIP LAVA.  To achieve this we believe
> there are two main challenges.
>
> Booting a disk image (.wic) on M-COM x86 in LAVA
>
> We went through the existing job definitions running on CIP reference
> hardware on LAVA to re-use if any disk image is being booted on them but
> did not find any. In every job definition, the root file system tarball
> and kernel image are deployed separately to tftp. We are going through
> LAVA documentation to figure out proper method to boot   entire disk
> images on LAVA.
>
> Can you please provide your suggestions on how to do this, if you have an=
y
> ?

Where do you plan to flash the wic image?
What does it include? (bootloader/kernel/rfs etc.)

If you are flashing the wic image into some sort of permanent storage I gue=
ss you could boot into a "normal" system using tftp/nfs etc., flash the wic=
 image into some sort of permanent storage and then boot again using the ne=
wly flashed storage?

Maybe the USB or SATA deploy methods could be utilised? http://10.226.36.17=
7:55555/static/docs/v2/actions-deploy.html

Perhaps this use case could be of interest to others and new deploy/boot me=
thods could be integrated into LAVA.

If an SD card can be used as the boot medium, another option is to use a to=
ol like SDMux. This allows flashing to the SD card whilst it's connected to=
 the LAVA worker, and then switch the SD card to be connected to the MCOM. =
I think there are also USB versions available.

> Once we are able to boot a disk image, then next task is to boot a
> security image.
>
> Configuration of BIOS settings on the device's firmware to boot a securit=
y
> image
>
>
> Basically, CIP security image has secure boot feature enabled, so before
> booting such image there are some settings that need to be done in BIOS
> such as:
>
>
> 1.
>        Enabling secure boot option
> 2.
>        Adding secure boot keys in EFI storage.
>
> Only after these steps, a security image can be booted on M-COM x86
> hardware. I am mentioning these steps based on our current experience wit=
h
> local setup. But I am not sure how to achieve this on LAVA.
>
> One idea is to pre-configure the above-mentioned settings in the device
> present in lab-cip-siemens-prag but in that case I believe health-checks
> and all other tests running on M-COM x86 can boot only secure images.

This is one option.
We could duplicate the amount of hardware so that we have some permanently =
configured in secure boot mode, and some in "normal" boot mode.

>
> Is there a way to change the bios settings through some arguments in the
> LAVA job definition ? If not, then can you please provide your opinion on
> the above-mentioned approach.

To be honest my history is almost 100% with Arm devices, so BIOS isn't my s=
trong suit.
If there is a way to remotely configure the BIOS over seral then it _should=
_ be possible for LAVA to do this configuration. It may just need some cust=
omisation work done.

Perhaps see if anyone on the lava-users mailing list has any suggestions fo=
r either topic?

Kind regards, Chris

>
> Thanks and regards,
> Sai Ashrith (T S I P)
>
>

--_000_OS0PR01MB6100DDA81973DC6533408914C2352OS0PR01MB6100jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hello Chris,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
As of now, we think flashing to USB and booting from it can be one option a=
s I did not find any eMMC deployment methods in the documentation. Need to =
check this further.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0=
);">
<span style=3D"font-size: 12pt;">As you said I saw similar discussions in l=
ava users mailing list where they suggested to first boot into a normal sys=
tem and then
</span><span style=3D"font-size: 11pt;">flash the wic image into some sort =
of permanent storage and then rebooting the device to boot from newly flash=
ed storage. I will go through those discussions to see if we can get any le=
ads.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt;">
<span style=3D"color: rgb(0, 0, 0);">By this statement <b>&quot;We could du=
plicate the amount of hardware so that we have some permanently configured =
in secure boot mode, and some in &quot;normal&quot; boot mode.&quot;,&nbsp;
</b>I believe you are referring to multiple M-COM x86 devices connected LAV=
A Lab, but I am not sure about that.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Thanks and regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Sai Ashrith</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Chris Paterson &lt;Ch=
ris.Paterson2@renesas.com&gt;<br>
<b>Sent:</b> Wednesday, November 27, 2024 6:28 PM<br>
<b>To:</b> ashrith sai(=1B$B#T#S#I#P=1B(B) &lt;Sai.Sathujoda@toshiba-tsip.c=
om&gt;<br>
<b>Cc:</b> hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =
=1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) &lt;kazuhiro3.hayashi@toshiba.co.jp&gt;=
; cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project.org&gt;<br>
<b>Subject:</b> RE: Booting security image (.wic) on M-COM x86 in LAVA</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Hello Sai,<br>
<br>
&gt; From: Sai.Sathujoda@toshiba-tsip.com &lt;Sai.Sathujoda@toshiba-tsip.co=
m&gt;<br>
&gt; Sent: 27 November 2024 11:08<br>
&gt; <br>
&gt; Hello Chris,<br>
&gt; <br>
&gt; We are planning to run software update, secure boot verification and I=
EC<br>
&gt; layer tests on M-COM x86 device in CIP LAVA.&nbsp; To achieve this we =
believe<br>
&gt; there are two main challenges.<br>
&gt; <br>
&gt; Booting a disk image (.wic) on M-COM x86 in LAVA<br>
&gt; <br>
&gt; We went through the existing job definitions running on CIP reference<=
br>
&gt; hardware on LAVA to re-use if any disk image is being booted on them b=
ut<br>
&gt; did not find any. In every job definition, the root file system tarbal=
l<br>
&gt; and kernel image are deployed separately to tftp. We are going through=
<br>
&gt; LAVA documentation to figure out proper method to boot&nbsp;&nbsp; ent=
ire disk<br>
&gt; images on LAVA.<br>
&gt; <br>
&gt; Can you please provide your suggestions on how to do this, if you have=
 any<br>
&gt; ?<br>
<br>
Where do you plan to flash the wic image?<br>
What does it include? (bootloader/kernel/rfs etc.)<br>
<br>
If you are flashing the wic image into some sort of permanent storage I gue=
ss you could boot into a &quot;normal&quot; system using tftp/nfs etc., fla=
sh the wic image into some sort of permanent storage and then boot again us=
ing the newly flashed storage?<br>
<br>
Maybe the USB or SATA deploy methods could be utilised? <a href=3D"http://1=
0.226.36.177:55555/static/docs/v2/actions-deploy.html" data-auth=3D"NotAppl=
icable">
http://10.226.36.177:55555/static/docs/v2/actions-deploy.html</a> <br>
<br>
Perhaps this use case could be of interest to others and new deploy/boot me=
thods could be integrated into LAVA.<br>
<br>
If an SD card can be used as the boot medium, another option is to use a to=
ol like SDMux. This allows flashing to the SD card whilst it's connected to=
 the LAVA worker, and then switch the SD card to be connected to the MCOM. =
I think there are also USB versions
 available.<br>
<br>
&gt; Once we are able to boot a disk image, then next task is to boot a<br>
&gt; security image.<br>
&gt; <br>
&gt; Configuration of BIOS settings on the device's firmware to boot a secu=
rity<br>
&gt; image<br>
&gt; <br>
&gt; <br>
&gt; Basically, CIP security image has secure boot feature enabled, so befo=
re<br>
&gt; booting such image there are some settings that need to be done in BIO=
S<br>
&gt; such as:<br>
&gt; <br>
&gt; <br>
&gt; 1.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Enabling secure boot option<=
br>
&gt; 2.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Adding secure boot keys in E=
FI storage.<br>
&gt; <br>
&gt; Only after these steps, a security image can be booted on M-COM x86<br=
>
&gt; hardware. I am mentioning these steps based on our current experience =
with<br>
&gt; local setup. But I am not sure how to achieve this on LAVA.<br>
&gt; <br>
&gt; One idea is to pre-configure the above-mentioned settings in the devic=
e<br>
&gt; present in lab-cip-siemens-prag but in that case I believe health-chec=
ks<br>
&gt; and all other tests running on M-COM x86 can boot only secure images.<=
br>
<br>
This is one option.<br>
We could duplicate the amount of hardware so that we have some permanently =
configured in secure boot mode, and some in &quot;normal&quot; boot mode.<b=
r>
<br>
&gt; <br>
&gt; Is there a way to change the bios settings through some arguments in t=
he<br>
&gt; LAVA job definition ? If not, then can you please provide your opinion=
 on<br>
&gt; the above-mentioned approach.<br>
<br>
To be honest my history is almost 100% with Arm devices, so BIOS isn't my s=
trong suit.<br>
If there is a way to remotely configure the BIOS over seral then it _should=
_ be possible for LAVA to do this configuration. It may just need some cust=
omisation work done.<br>
<br>
Perhaps see if anyone on the lava-users mailing list has any suggestions fo=
r either topic?<br>
<br>
Kind regards, Chris<br>
<br>
&gt; <br>
&gt; Thanks and regards,<br>
&gt; Sai Ashrith (T S I P)<br>
&gt; <br>
&gt; <br>
</div>
</span></font></div>
</body>
</html>

--_000_OS0PR01MB6100DDA81973DC6533408914C2352OS0PR01MB6100jpnp_--


