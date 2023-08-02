Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F58C001DF
	for <webhook@archiver.kernel.org>; Wed,  2 Aug 2023 12:25:58 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.137])
 by mx.groups.io with SMTP id smtpd.web11.13406.1690979154498407622
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Aug 2023 05:25:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=BorXUcGn;
 spf=pass (domain: renesas.com, ip: 40.107.113.137, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bF69laZwqgOls0OSmZ401QhUAD5G3SrpX+7KNgSvmK05i59T5uj+z6Mn7OzCvKkl1J/3UPdRVbHdbhWyEzys2SkMeeHESUAgLci2uihy8hUkJPncmNbpIAIOGPzMv2y8XuXHFScgfpFvUWx5wEwh8ncW5WBaiH9LJQpB6fYuYpI4bea5d6bYg/Q5i/NLvFZi0Dx0MLPI8zA5srkc82icP6xhqc1rwHfoqhtdc0wGtOi+JRXXRbEj59JSc0dvZqpDsmRFlZhszBhcrH1UHwrkA3CgaV8m0jBBRTqmluGTNb0ZoL7DrtyZTAdzFsU80DR1OVG6ST8MiIdaAMRqf/BbVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vnx9kOe1SrFVKV+K0UpVSun/UADXxq8rvyZplqAuLJE=;
 b=QymC/cVp1BEJZjiH/xUm+nueI+/9N3qsOqjEOvbZfLfYjrSQgPiSFJTOyHO1JQP4W1GpHsDN+H5ZSjsFVN7bTGGS1rTlvV4HxZBbU6DWMItnQo9MBLuFR7hcKqpajdRDd5LXJQMJOUVPhOUe8NX/EQKjJtyvvq+aEXJ1VY6wB7ZCTXcD1qSBGQuxrzdru2x7gdKE8QLR31kjBIK7tYTXxVeyvosAJ1VTW9jgM1P8z0KPBCQQHffyT40lZUgfZTJBJpZ1PvVP9G4aRC1MASefvxJnC4bBOxswsMEqE9wClYjC8CIcEWOItbEgcaim1x/tSCbwJHjiqrawX2WJqXYZlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vnx9kOe1SrFVKV+K0UpVSun/UADXxq8rvyZplqAuLJE=;
 b=BorXUcGn1IUJbrjzqAJKvA3VrY+uhe/Jlf+WyE0r0UKXplhfIsKSHMxcQK4Ecl1Mjr1HzcYy6c7huK7AJmdTx0IgDNGXWlizVzvD+En3R0qHdiFysrS6MAQiZ+lECUMR9qkcHoqJQCL5Xq743LNKfnjgKM/+pmEA5N8Ji0uFfRM=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYCPR01MB5997.jpnprd01.prod.outlook.com (2603:1096:400:48::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 12:25:50 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::5cff:5d90:9b08:6a7d]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::5cff:5d90:9b08:6a7d%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 12:25:50 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Michael Adler <michael.adler@siemens.com>
CC: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] stable-rc-ci tests failing
Thread-Topic: [cip-dev] stable-rc-ci tests failing
Thread-Index: AQHZxR9ONsUbi57YE06aGQY191NQb6/Wtr8ggAAJXbCAABYEgIAAF5jw
Date: Wed, 2 Aug 2023 12:25:50 +0000
Message-ID: 
 <TY2PR01MB3788D79592068F488400767EB70BA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <ZMoaWmwWiLQz+vNU@duo.ucw.cz>
	<17778648DB0D91E2.2497@lists.cip-project.org>
	<TY2PR01MB37881707081B7D70710B10BAB70BA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
 <20230802125753.4d2e6225@backstein>
In-Reply-To: <20230802125753.4d2e6225@backstein>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYCPR01MB5997:EE_
x-ms-office365-filtering-correlation-id: 7b09e43a-896d-42d1-3a9a-08db93539bc0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 MRMp/V2vSxmlPllB797zw49pLzbRLSWS8bNyq0mpvQHO5RXDOWkqWW8xuqf+bv6ftUWE+ksNOr1cNDtHsiTyZoLOQRUj4QKU0f/xJawhbjF/3LMOS7Enysx4ntA+lYx+8Fmjox1Ebkwg3nPnINms6sdakphcptDK11+FSpt/zdG/+VjB7bj9CKqKImyZRs7nydMzdwsncPias847W4mJYy40/ToKY4/0/CjB7PhkDNrL9Pznjhi8dQ0QWDX2x0f5EUnI8q2SIwGydeiudqeahrVQcc5nvCr+HlOM9NyMaSfzUzRgvleAkVmjJEur/Z33c3QVDjf3RrM7JrR7mh0snK4x9tHCPUln27tnu6F8nxNAtn8Oz2Dt4k5w4YJdersJ+3EdKckZ3z9ZaT86uCTDkDkZUxX8hAujPVT7Fxin5MJHqPncyrZadk1vu/E88VsicB7LBvXZJvKVYhRNfGmYpiruIZdFFMXZty/AtR+6szzz9xnBTY+5PedZouq6ySINTSOtdX0db1KJ0l1INLy7SNJKxnzC65GfpxijtuDd8h4Ut41XCHzFWksIxcW7vvAchGXktbCDLbNE9tJAU2z256W5yUArZH4SVo2ecDGXZVVGd4uPXWDNZknVbPj1GVP2
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(52536014)(8936002)(8676002)(5660300002)(41300700001)(2906002)(83380400001)(38070700005)(55016003)(478600001)(54906003)(122000001)(38100700002)(316002)(86362001)(6506007)(64756008)(7696005)(76116006)(71200400001)(66946007)(66556008)(66476007)(66446008)(33656002)(4326008)(6916009)(186003)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?juBGMjjZvkkPKO1DwULKLM2JRFQrceMuEFZ1uGt4j+xwpDPYWiWJe85E?=
 =?Windows-1252?Q?gJT1xX/C219ABhm6jhasyyD/apurwjeTt61EOUk3/9iVQT2yzCRnxDvN?=
 =?Windows-1252?Q?TKOrV2xNcyVY54byE9hng/WYbiTYjB8qyYxMsn4770PMs/MxqzXa3nPc?=
 =?Windows-1252?Q?WUcvc+jdtPnrNy3eDY+Uui2I7sfJT0xPp2AVbrcZq+nCQb29JZ85sr53?=
 =?Windows-1252?Q?97HlMJ/VBPcOAfGx0ySiHpr4zhMjR+aLwBVl7PXQ8Bc9Cl424hnKL/rw?=
 =?Windows-1252?Q?+P5k2FfjHbmjyvyvZbV11NOa39W93PsKrZFueJh4LRBdLd/aI5PHPnFg?=
 =?Windows-1252?Q?2tlEQspVj62iDhv54FJeIshgbsIZvsUKEG9U5gfkI9MAQnnGby1GyPKW?=
 =?Windows-1252?Q?pKg+s9Ar869sNoSxmhHX+ybJHoCBpHOBh5gD/f51VLLYKvXzu1b4RUAO?=
 =?Windows-1252?Q?zk1oliXEjpTZkk9bQw/7Y51WBmfGvrqJiBqYhFnXAV60V4cOc3+MDqnn?=
 =?Windows-1252?Q?06xhREqxHvTLbpdoyJZNPDJu7+QOgWfN8QdepQvJKP/yrej1uztxfFGG?=
 =?Windows-1252?Q?ovtvXR8meWCyTnBD3Ssg0WfjM22wvehL6wc8VmW+Mo0RHpPYF+znz30c?=
 =?Windows-1252?Q?EGBS8Z6ibMkRR9HjTA+WxzxMjktLiyG9BLVI8jJhGPe7tbXpDkNVrtlk?=
 =?Windows-1252?Q?H/j2i1pdOgeNeQAeQi1wy6qtE7Xz4444hxw2b30jUqvNh1FGd+UQ81md?=
 =?Windows-1252?Q?GpbbqRfPRKLSBLVsXYKeO7Nh4lSyl05hM+rhkaVWM0l01JvZppKp5A6H?=
 =?Windows-1252?Q?MizfX3EyLLYleHGkgq1pt5itys/iDsS3J2pb+KNOmLlFXopdhgOiwwmy?=
 =?Windows-1252?Q?Typ5ZXGMg8JHOxl/3NY/QKfPKEoKJtDRkOTG+E+N9A32aYb/Ox2t2E2M?=
 =?Windows-1252?Q?tIMfKMeQ4kJ2Fo8PuObWJW456TGIweRHIe75s4f+aW2dzzQ1TKDdMBGD?=
 =?Windows-1252?Q?PowkxmVPbkPqfosl+qzEob9AJvb/RHHZ8cUneJ+HHuWzwOckr64DVr8W?=
 =?Windows-1252?Q?rH6NRilREwve8TduND//NDXWP0SQG8xRq/xNIZ/M9tM1DSkmbxLY6jzN?=
 =?Windows-1252?Q?swhrqHalm6YmCV6/tkS02Ygbs7H/E1sSI9/5nWjr5DmlyTExRwbTOUdZ?=
 =?Windows-1252?Q?Xjlqrs+E3OsR1+xymyaMxscLWmfCGWRF/Xiv7sFT+FJAp9NlQ3luFcXZ?=
 =?Windows-1252?Q?O3LdWBFkmkC8mmKGTigejYtt+YcE3Jd03H7B/vqUGEMPDu5Yikymcx+X?=
 =?Windows-1252?Q?yxPQHpAhAm547MNooRCfcp/s6wuUqvoCJ3m0bUzFtJ7MneCJ2ZkCVYK1?=
 =?Windows-1252?Q?E1bVJpUYOlQ4tQ91aZOsBDnBcY4YE1rjKC1ooc0dnJv+9SJOPm7h3ShJ?=
 =?Windows-1252?Q?LkyHVFTR336Yx8+tGi603o3MSBq+4JOr7jCa4MkwdEJ3tb+PRctkDtcT?=
 =?Windows-1252?Q?2JYR4xoM3gGs6+pNk6+eyY4esICRHssBSgpsjXH6rfhDxnfKPASgp7C5?=
 =?Windows-1252?Q?Jn6KYmq8FGbCvphmlQjKiqtKaG2fd+memPdRqPRLQiMh6LutWwZ+siqT?=
 =?Windows-1252?Q?GaITHDPO0MxMA9Stx2fjjPGzYAAhubZXIamPdbwcVoD6/OfmoWGJfWk+?=
 =?Windows-1252?Q?9xpUDo/8mvs=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b09e43a-896d-42d1-3a9a-08db93539bc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 12:25:50.7690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p1JELKqRB+sSS9B7rBgZzsPZeMALe7F7PPqmEOv21vCDIQFnhtHZ7be9j2gMlaFeTJ7jtfgFAt8orXqJkT3drrc4IR8vvCwnoIZMDNR39ps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5997
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Aug 2023 12:25:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12535

Hello Michael,

> From: Michael Adler <michael.adler@siemens.com>
> Sent: Wednesday, August 2, 2023 11:58 AM
>=20
>=20
> Hi,
>=20
> it looks like AWS has got some problems. From the logs:

Thank you for investigating.

>=20
> "We currently do not have sufficient t3a.small capacity in the
> Availability Zone you requested (eu-central-1a). Our system will be
> working on provisioning additional capacity. You can currently get
> t3a.small capacity by not specifying an Availability Zone in your
> request or choosing eu-central-1b, eu-central-1c. Launching EC2
> instance failed."

Doh.
Do we need to consider adding some sort of fallback support to gitlab-cloud=
-ci so it'll try a different region if we get this kind of failure?

>=20
> In general it seems like autoscaling has some issues in eu-central-1a
> since I can also see i/o timeouts. I'll try to spin up a new cluster in
> zone -1b.

Thanks!

Kind regards, Chris

>=20
> Kind regards,
> Michael
>=20
> --
> Siemens AG
> Technology
> Connectivity & Edge
> Smart Embedded Systems
> T CED SES-DE
> Otto-Hahn-Ring 6
> 81739 Munich, Germany
>=20
> Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim
> Hagemann Snabe; Managing Board: Roland Busch, Chairman, President and
> Chief Executive Officer; Cedrik Neike, Matthias Rebellius, Ralf P.
> Thomas, Judith Wiese; Registered offices: Berlin and Munich, Germany;
> Commercial registries: Berlin-Charlottenburg, HRB 12300, Munich, HRB
> 6684; WEEE-Reg.-No. DE 23691322

