Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAB5C6FD18
	for <webhook@archiver.kernel.org>; Tue, 28 Mar 2023 13:59:46 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.132])
 by mx.groups.io with SMTP id smtpd.web11.67255.1680011976405541270
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Mar 2023 06:59:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=gyA4Xl3U;
 spf=pass (domain: renesas.com, ip: 40.107.114.132, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mw2tFDIZ5423PMZkyOOiHRTRvfaaAUhy3SHAZy1Vcipj42IAuzdVgcmF0YAkQxiz1PJla8G6LtDtM0jKe1YrAhTzfZ8mw/oC5xR//25dF5UWhhIQX4e26eMCyB6v161CPsBf3Mhw0JhxsdbCAOTLAWzUcfEW8uWltPh1Qa7Le/SZzBzsbiDNVga/4Cs6k5RCsy4i+2RQIf/NTTgX5MbUm9Xg/e+RVkYQlDA+GHfCzCYXLgr60LkQ23ab2LmQ8m6qaZ4ffk1uKzDKBO4VFpH1cClzxpTzdiGqZOp8krK+jNWv7/CrR8Xo8OK6lqGfDIJWVojv59JbOLITpfFz9/plzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+GS+tLuBUW7vCwfY/GPzIKQ4Yi8viUKTmkV2qwxoO4=;
 b=l6NqONoO76I22f3rIjQ7EkPQL7Gi7L0/X2MzTDrfWMsaxNvWeLYU39tnxBnX9+Y6qAzTQQX5tdCNWq5OZFaLP7MNpuv9Zcs+b8oSAndMNDgnRBhprN35WI93sKbJMIcTsQfOeM1gsVOIYWwfdZXPLPZMV5/lPpn+JC+gI/2/azEtwJvfClAR8ozZHrpFrCgx8i9PeMkhf8k6z7Z/ygK7KS/Lm/kheinEpSPKBiqSn0fvzKrOWAtfZab9U5fJ/UZB49a/ViZUmOimlorLzaoAIBtzvcqqMmS5iFwBOmnMjqxbdJ54u1cYpkblw9ZZufz7+yEAKWW4CxmuCA1ytMUAGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+GS+tLuBUW7vCwfY/GPzIKQ4Yi8viUKTmkV2qwxoO4=;
 b=gyA4Xl3UFU9wrHWgNIn8W9hP3QIzdiSw/7JbgL1eYfZGJ5SzEsqnv3+rjOiu579ci0LscSS1VLof8eVudt6+bVdsnPk94T60f25ozCyGdwOn60F9eVTYUxeDPfMfvGM3OJ5mMZxdNtakUFl7vp8pGS5ni1H3WQz2q7HzJeSja48=
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com (2603:1096:400:309::8)
 by TYVPR01MB11261.jpnprd01.prod.outlook.com (2603:1096:400:367::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Tue, 28 Mar
 2023 13:59:32 +0000
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::1447:8fc:6a25:d78a]) by TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::1447:8fc:6a25:d78a%3]) with mapi id 15.20.6222.033; Tue, 28 Mar 2023
 13:59:32 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "stefan.ss.schroeder@siemens.com" <stefan.ss.schroeder@siemens.com>,
	"GeorgeY.Hsiao@moxa.com" <GeorgeY.Hsiao@moxa.com>, Kento Yoshida
	<kento.yoshida.wz@renesas.com>, "Philipp.Ahmann@de.bosch.com"
	<Philipp.Ahmann@de.bosch.com>, "sandeep.shivaraju@toshiba-tsip.com"
	<sandeep.shivaraju@toshiba-tsip.com>
Subject: RE: About CIP Security image generation
Thread-Topic: About CIP Security image generation
Thread-Index: AdlWaUPbaGgryGgHRRCdsfXTRcaqSABotgnwACNzLqACNmyWEAACbxQw
Date: Tue, 28 Mar 2023 13:59:32 +0000
Message-ID: 
 <TYCPR01MB10588294058B29E93C8326C4EB7889@TYCPR01MB10588.jpnprd01.prod.outlook.com>
References: 
 <OSZPR01MB85155EAB6B807A73E6A201A4BFBE9@OSZPR01MB8515.jpnprd01.prod.outlook.com>
 <TYCPR01MB10588EDBBF653B6739E9E190AB7BC9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
  <OSZPR01MB8515AC13CE5D4C72ACDE4CE8BF889@OSZPR01MB8515.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSZPR01MB8515AC13CE5D4C72ACDE4CE8BF889@OSZPR01MB8515.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10588:EE_|TYVPR01MB11261:EE_
x-ms-office365-filtering-correlation-id: 5fa7e546-d319-4468-dc08-08db2f94a841
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 OVzQdKJziSThSVepDN451UxA38Lji0wPkVR76bcJFDy4pKQu+3OzDfc4Dz5vCh4YSgzRfHir5/UNioVi+2w8EVxDQwnzz4Cay8/W/+UCAkf52fFdqDDFwfsniwE3BdUx4u532gkmBg247p+xH4jGuEZFB6ra/YiPWETvulqj8gVJ2abFPFwZS6VYMcELskS3Y22Rlnfoe2KVZdN4vx3OME3jiMVEqPV6Oz/lKE4Vuuu1IvnqqkPtD8UPaERyxJyyEzooXYEAXJnxMPNpkqpHxs1RTqSAD3bsNz4AlUoVoOLzuzSgMEIbN2OcEr/S5KPFb7kxDGjqdYEKql50pgbsQHHcYD8l/C/RClEirRacAjNndgRybvoyWGgDddLAfb+cnPYf8Im+uE437BQEyl7fpqVxMHXXBqiqRDcATwMZiJ/eu9Yac0+v0W3wLWUJ68DkvxL1dASD4XyD+oOJT3rz79H0iz2CmvA5maZtJNqt3ai8qTb8YYs3m1hFCrlnNK+QjsRnisnuQCqHVdbYIJkyaDdvt9VoEYLLQI8rUlmjxzrBPzLeuMPEKvO6dEfxuMNdqJ/8ak5s7zVzBl3gvVq+hiflkETCwJNA50DnitxzbWdrppwGJGJ60n+/DmqbIt/m
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(451199021)(8936002)(83380400001)(41300700001)(52536014)(86362001)(38100700002)(5660300002)(33656002)(122000001)(66446008)(478600001)(71200400001)(7696005)(76116006)(54906003)(66946007)(66556008)(64756008)(2906002)(8676002)(66476007)(4326008)(15650500001)(4744005)(55016003)(6506007)(186003)(316002)(9686003)(110136005)(38070700005)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?SFZUbnNibFprZlRHUlN3dy9UZUF4ektBVVFVd0tMUVJhanlzQUM4QXU1?=
 =?iso-2022-jp?B?MmtMUktyOUZ3c3dhY2hXTUMrYWU4bCtyVExZdkFTZE9LUFdjMjdRSUJW?=
 =?iso-2022-jp?B?cjgwUXpQamJJTDNXbVp2VXplbFdqUStydjg0ZWpwclY1NFc2Si9QZmJE?=
 =?iso-2022-jp?B?Wm5qeDZKZmJEdmJOZjdhVVdJeWY1TlJ4TDYyTGg3MGN4MWV5dXE5RThN?=
 =?iso-2022-jp?B?OW5nRUE1b0EzU2Y2b0xkVm5nbDlQSkExS0hQZkJXbWhlYk9hNGdZQjdF?=
 =?iso-2022-jp?B?eW9MYzhockV2T0JOSjVIMXYyRmZ6ZDRVcUVhblAvR0JIODlUbDRsV256?=
 =?iso-2022-jp?B?bTdpbFN3YmI1ZzRjRTJaWWJhS2xEMGZRcEVvc29DUldmdnZtV29aWHM2?=
 =?iso-2022-jp?B?SFVHdCtnekxWT3lmS2JjMWgxRm1Qd0EyREc5ZjBNV2tWS29xRytKNDQ0?=
 =?iso-2022-jp?B?SURTOHJSbWxtejVtNzVQMmhCMVNHTlBoT3VBVmZ2YWxybzJsMVc3MXhK?=
 =?iso-2022-jp?B?c2lrZ1ZXTkw4dzFCTVEyeHNNSzl0QUZUMGpQVEtCbGxrWktGektpMFF4?=
 =?iso-2022-jp?B?ZXZaL3RFTkdBR0FWVmJSWFM1ZFdRZTR6cm56ZHBTWk53M1ZBUjNiWmQ0?=
 =?iso-2022-jp?B?eDdoaDl6RE1RNnJSZEhGTjdDa1BOL0NmTksybGtaOUdmc3BBT3E5ajU5?=
 =?iso-2022-jp?B?YVdUbElRbjE1L1VIQXlNcGtQOU5XbVpvelRxNWUrRjdWU21TbnZTdzBs?=
 =?iso-2022-jp?B?QXV4cExhc1dMZUZEZjRISFFCeHJJU2FDMFo2WllzbWMvZThuazNtMVdM?=
 =?iso-2022-jp?B?ai9wejhjOE1uOWFsNEN6SzFqVzhsc1ZPOWdmT0VLTi9tZmRESG1pM2Ux?=
 =?iso-2022-jp?B?dzFYY3ZsdU1kRk8wR2twUGZ6K2NpQll2U2N5V1h0ZmpYVE5UaU1MU3h6?=
 =?iso-2022-jp?B?OUJSdEpYbzN1Q1N4S0kzVVpwT01rTjRlMzR5bzhqRmZOUWdsZ1dveFRG?=
 =?iso-2022-jp?B?eDBUS1d1bEUvY3R2YUVjMk1uOG1LWUVDb0cwYmdydE5VNFI3ZWh5VzdV?=
 =?iso-2022-jp?B?Zk91TjVicmJsdmRhUFBTaHluRE4vcnkwcnAxYWp1N2ZSVTBPMVYzNm5H?=
 =?iso-2022-jp?B?aVMxajJnUzlqVVJsTVI2Uk1zYXh5NytGUzNrbjRMZEhEZll1bzBWOVVI?=
 =?iso-2022-jp?B?YnFrK2FTNUxQT3hiRlpHWTVZZEtZRmp0NFVxVnNKSTFlN1FwMkNFU0w5?=
 =?iso-2022-jp?B?Q2hpYkJUY3VlY093UmwyYkxNQkpxWkNidDFZaHh2bkUwRTV1SnRFaFdX?=
 =?iso-2022-jp?B?MVNwaXIvdHllZ1pXRkpoS0Z5Y1dDS3pML0ZnTzFPaENBcmdXV054bkwx?=
 =?iso-2022-jp?B?WFBFL1BuK0FzQWVybC9PTnU3bzVmTVI4bEV6alFlaGJtTkpOT0d3UDRT?=
 =?iso-2022-jp?B?bGFPdndVVGdWN3JrSVVGQmlMZW5BaXUvWS8wM1REa0RhQk5udkw5UW9r?=
 =?iso-2022-jp?B?NFAwVE51SHVoZjdpMlJvd1ZoL1hpQjNjL05jbFE0OVlxNm1TWFQwbjRT?=
 =?iso-2022-jp?B?UnlYZWFPUkxXODBwMnd6WVNrMHgyVU9RUWdSSGpHaFBnMDRHazlZemZT?=
 =?iso-2022-jp?B?YWlZcGI2WjYyUVg5c3ozRVpTTGtOaHUzQzVhNGdnaUtpWmhHRDYwUk9D?=
 =?iso-2022-jp?B?a0x0YWJZWkQzU1hJTnhwc3FQdEhtQXFOeW13M21IbnJ5WFhFd3FXaVY4?=
 =?iso-2022-jp?B?ZTV6R3VpdTdSZlhlWHg5WUdhSWZnUE5OaE1NNGNkU3FWWkZpSDA2OHNR?=
 =?iso-2022-jp?B?czJjR3BaUXprUFhvMzhZK1dwSlhiSStjQTdFZUlFS2VQZ0RuTFlMcW4z?=
 =?iso-2022-jp?B?SDQzL1ZUbWp6anNySUR4dVZrbXlPUG93UHZIVGMybUVJL1JXSklWV3lz?=
 =?iso-2022-jp?B?RFZGNGJvU1lSWkt2eFEwdUllUFBJT2ltdnFZMk9LNUhvSG05ZFMzeXc2?=
 =?iso-2022-jp?B?TllxMk5Vdk0zYWlzY2NrU3Nyd2s3SGl3bUpFeWpHNVNtSGI2QUlRbzJo?=
 =?iso-2022-jp?B?QlJrUFV0UG5Wa1RtVE9Bd3dIM3g2U1ZaaWNMWTFNR0JtTXZHczhHTmox?=
 =?iso-2022-jp?B?RkFUMXRhR1grdTdmbTNNMWJzR0dlK3o5K0dsUzdWNEowdFkzQkRUYVBI?=
 =?iso-2022-jp?B?TWtjU2dSTUNBbU1CUFBYQjk2WTF5NkQxbmt0OW1SWVZYbjZ4OTNJcXZS?=
 =?iso-2022-jp?B?bVRub0pPTTdpM3FaRWxZWjlWRmU2K0VVNEVMTjVaaFRQRTR3RDlRR2JQ?=
 =?iso-2022-jp?B?QkpQZ3lXUmI3S1c3RWZLd3JyVXJFOWcxSlE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa7e546-d319-4468-dc08-08db2f94a841
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 13:59:32.7383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 66VwLgWBLqEsZuCECF5WVsl74f2xQnzKuIF50pQjW2GA4OjT6CbRvJxHNmXnzEicTWpjJfETyQ/Tsojnra134EPhCVqVE/YqNtTFJtZw1IA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11261
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Mar 2023 13:59:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11121

Hi Dinesh,

> From: dinesh.kumar@toshiba-tsip.com <dinesh.kumar@toshiba-tsip.com>
> Sent: 28 March 2023 13:53

[...]

> > >      Cons: CIP Testing WG needs to separately test each image.
> >
> > This may not be much of a con in reality. At least not unless we start
> running
> > a lot more tests with these images.
> >
> > If we have multiple versions of cip-core - which do we use for kernel
> testing?
> >
> > Dinesh> As of now only two images of isar-cip-core (one without securit=
y
> > packages and one with security packages).
>=20
> Is this reponse sufficient for your query?
> As you know we are planning to release isar-cip-core meta data, so we wan=
t
> latest kernel testing with latest Debian version.

This is fine :)

Kind regards, Chris

