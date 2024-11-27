Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39821D6ACCB
	for <webhook@archiver.kernel.org>; Wed, 27 Nov 2024 12:59:00 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.57])
 by mx.groups.io with SMTP id smtpd.web10.71064.1732712331773441503
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Nov 2024 04:58:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=jF7HvOJp;
 spf=pass (domain: renesas.com, ip: 52.101.229.57, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pRr07dRsN5y6Nrz4SwFHaL5juwocdCpX9NiJS3vLtcB5D2iIxPrdoJjeuSmpBIdW6Xlm/w95g4h4FJWmjdc8jv75HxueC7UQ339tn+i8hROqAhxvLoYKS0RrQdixytjoO1+8xKvmwM7HX7H/xjIToiii/uMFovahBcKCqCAcfCtdc8DFMKZrE7kY0kQIftzINavG3DaIq/ZtpjOjCsiFlwUZ4Wi7ESpHlfwev73ihNSjM2+Z25MZHZD7tsaKbYqol3H99vnPQTirVMgvtMZVBhVxE7T/l/72P6wrtLEManQqfcYhyZGQuV68qZrEc1LU2lNl+/n7CKnfk+1xaeuGuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4s8djnOc8LiP/GUveL7+Y48vgi0dFVL60zKCd0J+AA=;
 b=xKWrHpV/EOceYfh/L/gbJS3t9oPexhowtvLchuuPV+zBvDkWV1gHhszjpaKPCOfjniSg3x69abjiZPAik+8iUXpmLQMvW0SumnSploDkUXrJKDL6QkJ+Rp9BpEHOvZH5YoIW9frb9QPK7BQKfnu4YfXChrHZfKA5wGBCpxZI5RoWmdrz/xfo7ksGb5Mh4VLyH2+badKJe2jAiYVWnsgOUIDNIK1rEtx5gG5Fq6dF2Zn1ieu/sqRNamUyAbJVNUTaLePLr1q7AbAIw7o9figXUcJLONT3bYRfDKGXuy3UwvRJO7wYEAMcqXgY379bLTYiBvur/6nZdd9yqcL5SjMIQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4s8djnOc8LiP/GUveL7+Y48vgi0dFVL60zKCd0J+AA=;
 b=jF7HvOJpG7pOteiyWBI2x2uwXZY13boH1YmHosSQDlR9HQ23jkGmIoqWFTzgG8T06D5/nIDlcB1DiWxljfghl3HQi3w9Bqf+P2MBnM94X0MoclFe21R0CXukO1H+/bNVeBV7t4tQS4pKZeyYAzTJ8SHRz73Wqu14eoz0kUckliA=
Received: from TYYPR01MB12402.jpnprd01.prod.outlook.com (2603:1096:405:f7::12)
 by TY3PR01MB10254.jpnprd01.prod.outlook.com (2603:1096:400:1d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.12; Wed, 27 Nov
 2024 12:58:46 +0000
Received: from TYYPR01MB12402.jpnprd01.prod.outlook.com
 ([fe80::64e8:dbea:c288:5e87]) by TYYPR01MB12402.jpnprd01.prod.outlook.com
 ([fe80::64e8:dbea:c288:5e87%4]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 12:58:46 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "Sai.Sathujoda@toshiba-tsip.com" <Sai.Sathujoda@toshiba-tsip.com>
CC: "kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: Booting security image (.wic) on M-COM x86 in LAVA
Thread-Topic: Booting security image (.wic) on M-COM x86 in LAVA
Thread-Index: AQHbQLwTUaTAYoFsNEu+W9FEgwfyArLLAK5w
Date: Wed, 27 Nov 2024 12:58:46 +0000
Message-ID: 
 <TYYPR01MB1240202744B87D2E939DAD687B7282@TYYPR01MB12402.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103FB47A8576B2CFA3275F6C2282@OS3PR01MB6103.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB6103FB47A8576B2CFA3275F6C2282@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB12402:EE_|TY3PR01MB10254:EE_
x-ms-office365-filtering-correlation-id: 485f3236-69ff-4af8-3210-08dd0ee33b04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?K1dkMlhLeFBKeEN0c1VuaFdIT3Vjd0hnTWlNUUk1K2REOUdqbkJCOW1k?=
 =?iso-2022-jp?B?M0VmUTFQd0twSCtHbmFyeS9ic0RhYkt2Z0VtQlhOVXE3VGsxenVVUm1L?=
 =?iso-2022-jp?B?dDkrTWM5b1lWOW9yMWZUdnNQMkM2aFBiSnJBRmlIWW12aHZYSHBpTWlu?=
 =?iso-2022-jp?B?K0xGb3NDYTk1UktVc1VZRnlhdG5XSnRHeGNaeUlIMWI4cjdEd0ZGQUhy?=
 =?iso-2022-jp?B?a2FwNktvbWZHYXBuMm5LVWhaOTR6Um9tYjdlWWtGMndIc20xcDdvOVRO?=
 =?iso-2022-jp?B?UFVnVlBEM1VqQnMydldPUXdjbHg2cW1VeFRMOHpnN2N1QTNJUnRWNnNZ?=
 =?iso-2022-jp?B?UEtBYjd2aUQvY1VxUWFEOUl0a1k3RGVvbG1SYmFpcVdXUjZlb2FmRE5j?=
 =?iso-2022-jp?B?R1RkVW55YjNZV2NoVTNXVktvOXpjWGhFd1BSeTkzbXFjYkRjNUJSeUVH?=
 =?iso-2022-jp?B?NHpKSmxTNndGdFN1dk01VWNpOWRSYXZDK2VncU8wVEkxalhkRDB1NDhG?=
 =?iso-2022-jp?B?TGtjZjhTTkF1TjVrTUJhMDNpZngzUzRVVStRb2wrQllmZkgya3YxTEx2?=
 =?iso-2022-jp?B?ZFI5V2pWRXp5TENQZ0xmcitZV3pYcHVtcC9Oc2xrTHpucDN2SUtBR3l1?=
 =?iso-2022-jp?B?TmpMTDVzOERNdXY5RFk1NmtzSGhIVFE1cmZ6L2NyU0lTR0xDanowOG9y?=
 =?iso-2022-jp?B?blFLSmE1bldNdEF2K05lUFRndDd6d1RjUWwya2hMYWozb2dtRmpWcStH?=
 =?iso-2022-jp?B?c1R2Tk1CN3NsaWM5VnJ3cW50Slk5UDl6bWlzbUNvaURCaWpRUXdiQ3Z3?=
 =?iso-2022-jp?B?amwzMWZrNmRVR2J5Z1hJcUVzdEFmMGlkSW1FWTMrT211QWpwSHUrMUQr?=
 =?iso-2022-jp?B?TWR0enVkRW5BL2Z3elpwU3hsblRTbmRNUmFVcFF4UTcrdkRIK1VvUFVM?=
 =?iso-2022-jp?B?TzZjRmlxWlRzTW9GbUlJUlh0eHpBTVdvSWFXUW54US90V2hQVDQwZTVn?=
 =?iso-2022-jp?B?MUg3RGlyN1Z5Z3U0WmdRVGdNdXJQd2JMMUkxWk9zTEFkVERVanB2OThG?=
 =?iso-2022-jp?B?M3VJUk1KTHRxTWc0V3pBaWdqbVBjdXd5eUxxN1VZQ0VKbGhyTEFJdFhY?=
 =?iso-2022-jp?B?RmxLUTlGY2NUZmgwL1YwRVpLNXBRZGdyY2F6Rjl6RWQzaktHcXYwOVdX?=
 =?iso-2022-jp?B?ZEFzeWdnRTdCY3FJZzl5SHBJNGdreEVyeWJZa0FTZWhKNTFPcTdqaGF3?=
 =?iso-2022-jp?B?bUhGTnJBaWZwaGdsTlFNbUhTZ3FkMUhuS2pGaU5DTkw5dVdreFdBWDdt?=
 =?iso-2022-jp?B?N3ZoVG0rcGgrYkFDWk5tZ2JuUWJtY293UEUrSGFZUUlWc2M1bzkvYXZT?=
 =?iso-2022-jp?B?eHFwdWluWkYzdHZKYVZWVVBLZEpOWVJrSkx4by9tWHlnend4VStHQzlG?=
 =?iso-2022-jp?B?cGRLOEg4VzM1YU4wV2EwRGV2aEY4TElveTN6RjVnZnU1Z25wNjNndlZz?=
 =?iso-2022-jp?B?elMyZEs5dWJrK3g1eEtUVklvc2RIUEUzd2oxQUNmRHJtUlFDdXFsdGEz?=
 =?iso-2022-jp?B?NWMvM29iUlI5Kzh5QW9aRkhRa3BJMFQxM2Z3UzFMV0MxbENsV2tTQ01D?=
 =?iso-2022-jp?B?THRsdGNYWmxqUUVQS21oMjN6MkErdHIzc3prbzVrUEtWYUptbWFsUmpO?=
 =?iso-2022-jp?B?SUE0YXQySUhEeDNFdXNNM0hpaTRVa0lHVHNRbUlyOHFpcWhhbDF6VE4x?=
 =?iso-2022-jp?B?Ri9INTNvVmhTMExxSTNNM09oUitwZFVieEtTNHNnQWptZUdFbXBSTE5X?=
 =?iso-2022-jp?B?M3dmeGxtRmlGT0xDTXhBOHNwV3kvUUgvWFVqRHVJSlhxdFVQYWhNOWhK?=
 =?iso-2022-jp?B?aTcxQ1JuNGxYZURadWJyVS9nQXZuYi82WGVvWkQ3WnlhQjZpR0tvSTNk?=
 =?iso-2022-jp?B?TU1LOWtKUFdOaStWT2wvZ3F2Rnd6TnZhUE5TdmdUenNNeEpOWlZqY3or?=
 =?iso-2022-jp?B?Yz0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB12402.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?LytVZHdjRnlDRHowMmUyUC9qYUxYRkRtWFJLeUhsK1RQYUtFWmUvNjhz?=
 =?iso-2022-jp?B?K2VMcW9vQ0crdW5WNUNzRnVzK25OcUs2MnJ5c2dsSEIzTnYzT2FQN01F?=
 =?iso-2022-jp?B?ZXJqQm51TlFwdTBXUkNPZE40UnBRSUdsdW9Bem9GbjJwV05OdXkyVDRN?=
 =?iso-2022-jp?B?djRMYjBOakVwMzdrQVJabGF1ZmhLaTVEcGFLaHBsanJpSmVEdERMd3pI?=
 =?iso-2022-jp?B?eHhXbnYwNnAxVFJ1cHhGRGduZlRLTnNRclNzQ0hSdjk0NmppSXpwdjkx?=
 =?iso-2022-jp?B?bzA2cHN2RU9Kd0ZsN1NCMlprM09UWXp2S0JReHBEeWRoTitsdyt3WHd2?=
 =?iso-2022-jp?B?WW9ldGpsWVBsZjk5TExjVGFVUlRSTzRxdDlTMmd4YWFXNTZkRFV5Wncz?=
 =?iso-2022-jp?B?SGxnY2RkVGd1MHowWGs4dWtNTHdYa1c4RVFvSXV5cE5mR1BjTVRKNG81?=
 =?iso-2022-jp?B?RWYxS0dIZXc2bllvWGpaY3Z4WFNGeUJITFNha3NrNGordDkwODhYNVRO?=
 =?iso-2022-jp?B?dVdQNGV4Q1JCZmhFNm9Ra3d6WlVtV1A0RGxxbnJ2ZEw3YnBOdHl4Z3Z0?=
 =?iso-2022-jp?B?OUR5ZkdobzZsQWpEMk1nb0dvZzBJYUZqcnllTk5PdEthdEpxTGFIMS82?=
 =?iso-2022-jp?B?d0tRUTFJNDkrcmlvNllkWGEvVHovUnpBZ1krNys0aHdseXNSUDVwL0lV?=
 =?iso-2022-jp?B?cllCTlk5TzFOQkZqbUxud05aS2Q4RWpDREFWcno4UDVOZTdmeEhjSTdM?=
 =?iso-2022-jp?B?Z0owcGRFMnlpdTFDTUtMYnVhQjJWNENuQUFENER5WmN3YzF4SHI1RERl?=
 =?iso-2022-jp?B?N1BNR2gvRExGRjcwdFB5WEtHY0lkbXNGaklyc2JTQ2NXbmhQNE56YzBh?=
 =?iso-2022-jp?B?Y1czeWpRMWRJZ2QvalI5bGRLMEh1L1ZudVgxWlRySUx4NC9jdE1lOGFC?=
 =?iso-2022-jp?B?Qkt3RnIwRWcvZFErRC8yRnBnVTZJMnRIVUY1ak1xVmhvNzd3YTdWVmxa?=
 =?iso-2022-jp?B?a2lCOWdIQzZaS0xyVE1JT0V6dTVwcTRqNVh0YTlOZDBnTjFTUDRIZG1V?=
 =?iso-2022-jp?B?UWovWFBaRTRZbW1Zemw5cUgyYXgveWxxelBRU3djdk9rRVROY3ZLdDA4?=
 =?iso-2022-jp?B?WmRWQlkweEhwMSs5TVNacGZvNEZhVnNxdW92SjE1dWIycHJOOXpQN2I1?=
 =?iso-2022-jp?B?Wm94MVI1dGtjeW10Z1NiMzFkT3BsK3NmWjM0SlFhVVE4anREYXkvSm0y?=
 =?iso-2022-jp?B?aEo4Szd6THZvdjVyRmlRT0tucDJkM0JkWG1FbCtVUTFsWFBIRy9kYndV?=
 =?iso-2022-jp?B?WCsrYnRNemVQWkxDNXNXTHRINllsT09KVllyMHN2V1RSWEtEeitHT2lp?=
 =?iso-2022-jp?B?VEx3T0RIeFJEYW1UZkxKSndtWHVpSkVPcUZBcU1BcXJYZjVRdTZRV2tB?=
 =?iso-2022-jp?B?eklMV0RqR3ZGYktGWDF6VGkvNGRUcWFzNWF0S0tYMlVUTCs3aFZldUZY?=
 =?iso-2022-jp?B?OHhIZ3c0TDMyK2wyUldqRGl3UXJRKzRCa1NEZzAzNERRZDlrNVF3bFhL?=
 =?iso-2022-jp?B?M3o0WE4xUUViOFY4aG1Kams4SUFORkdXV3YxblEySmttU0lqWjJuMlZC?=
 =?iso-2022-jp?B?YXJOTEVNaVNIaERGNVpDc0xicTNRKzF1RkVucUFaSDFHL3BnTlF3Vm1W?=
 =?iso-2022-jp?B?MXhvVmJoZW1JUHhEd2tzZFJzZjhPTk1HVkcvcEJuaWc3MWFPVWJlSHUv?=
 =?iso-2022-jp?B?R0dsWlZOWmVLV0xaanhmUnRYaGNQdGl4bTdpbHh0ejM1RWpWbVdQMUNG?=
 =?iso-2022-jp?B?cGtYRWJEOGZvS0VwWUpIWDNqdEVjQUM4WWRRQTlHSmtCMUxlQ2lTYVkx?=
 =?iso-2022-jp?B?bGdBYng2T3RFcGVQbDJaU1pQMnkya3VycHFnTGdLR0NVdEFaU25xa1Zi?=
 =?iso-2022-jp?B?Kzlqd3VGT0plYlN0NEMxcHJjeHZSSTQyMUxSblZUa0ZoZGk2YU5OalhR?=
 =?iso-2022-jp?B?OVR0bEIzTnNlemlxenZRdCtmWU1DYVl4VVFUWkZPVitKMnlabnhlTmla?=
 =?iso-2022-jp?B?dXp3c0NTQ1lBdkNFblpMdmRyTUdHVEg3a3Bvdm9oNmVVbWNOcDhJeGps?=
 =?iso-2022-jp?B?UlJXb25HRTdJSzFVenR5NHF5QmJFMHRNUDVscWthYk9EMTVlb2ZHME4x?=
 =?iso-2022-jp?B?Y2IxZEo1WFV3dmdCRmtpYmVHVDI0aWZaWFdGbFRNNmlJQ3g4bDVld29U?=
 =?iso-2022-jp?B?K0FtSjRJbTM2Y1ZDdUhrVFNPbTN0Z3FXK00rOHNIOGh1NUVUNmFWV1ZF?=
 =?iso-2022-jp?B?SWVnNXFzbUdYVmFpSlpLNzY1N2k4aWpIb0E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB12402.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 485f3236-69ff-4af8-3210-08dd0ee33b04
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 12:58:46.6664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q+b75d++j2QymwblMZSNtxmxeWHUGE86RHtLaZyfWFok/gT9Ny6vYCy2bCeW4k+QyAqpj5NA/rP7szSrR1JcDCLoXvXMKijXJH+aNud5m0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10254
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Nov 2024 12:59:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17291

Hello Sai,

> From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>
> Sent: 27 November 2024 11:08
>=20
> Hello Chris,
>=20
> We are planning to run software update, secure boot verification and IEC
> layer tests on M-COM x86 device in CIP LAVA.  To achieve this we believe
> there are two main challenges.
>=20
> Booting a disk image (.wic) on M-COM x86 in LAVA
>=20
> We went through the existing job definitions running on CIP reference
> hardware on LAVA to re-use if any disk image is being booted on them but
> did not find any. In every job definition, the root file system tarball
> and kernel image are deployed separately to tftp. We are going through
> LAVA documentation to figure out proper method to boot   entire disk
> images on LAVA.
>=20
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
7:55555/static/docs/v2/actions-deploy.html=20

Perhaps this use case could be of interest to others and new deploy/boot me=
thods could be integrated into LAVA.

If an SD card can be used as the boot medium, another option is to use a to=
ol like SDMux. This allows flashing to the SD card whilst it's connected to=
 the LAVA worker, and then switch the SD card to be connected to the MCOM. =
I think there are also USB versions available.

> Once we are able to boot a disk image, then next task is to boot a
> security image.
>=20
> Configuration of BIOS settings on the device's firmware to boot a securit=
y
> image
>=20
>=20
> Basically, CIP security image has secure boot feature enabled, so before
> booting such image there are some settings that need to be done in BIOS
> such as:
>=20
>=20
> 1.
> 	Enabling secure boot option
> 2.
> 	Adding secure boot keys in EFI storage.
>=20
> Only after these steps, a security image can be booted on M-COM x86
> hardware. I am mentioning these steps based on our current experience wit=
h
> local setup. But I am not sure how to achieve this on LAVA.
>=20
> One idea is to pre-configure the above-mentioned settings in the device
> present in lab-cip-siemens-prag but in that case I believe health-checks
> and all other tests running on M-COM x86 can boot only secure images.

This is one option.
We could duplicate the amount of hardware so that we have some permanently =
configured in secure boot mode, and some in "normal" boot mode.

>=20
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

>=20
> Thanks and regards,
> Sai Ashrith (T S I P)
>=20
>=20


