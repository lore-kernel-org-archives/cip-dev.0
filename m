Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720E3E77188
	for <webhook@archiver.kernel.org>; Wed, 18 Dec 2024 12:48:05 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.23])
 by mx.groups.io with SMTP id smtpd.web10.104571.1734526075544637997
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Dec 2024 04:47:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=HsY+Wgih;
 spf=pass (domain: renesas.com, ip: 52.101.229.23, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OcqwQcU/p/cYXmuor+JFFce0EjBneG9pPeMnyublRBw62tyeR2LqX82N88hq8A5fGmrz5nKa562ddWEfcc57u73WGPDD4MZmfUP9MV2PUAC3P98KYK2yJuv337C93SeJz3U7QLH6leeAAP/bobub+EGtGboml4SKCANdyPVqLK7MDq9dIivv6tbFWGEVjJYR2bS8t+dRbHk6NylEQO3WLUsN5Ln1TVbG/qbYTN9NU3sjXRPgVz5d+FfjeMouprudJklcq6uY6NQxi8y1/YL1/+g2U9LrHN1Tz33kCy/LNL4UanP13P/nWaJSyp14CMyZO6dWne7lLQFWqJWDAl+6xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vkq3D8I6WqrsyhYzrBas6V74s58cS1Oijq74cTXSKm8=;
 b=q2Ar1QFeMJKK5570vzfyPs2U4adIXzZIv40IUNYiT7N81gYR/V7LpyWILSPvsHDH3sA4/YuizqPbjsPeoP0F2i3uPWPaWtlASoAwFZs3XxrZChic5DRzBkP4IblMZY4e43nIyupTZs6W6Wf/8af7O33mciF5DiCtNz8UHuQ60CeXhCea1MH9ysHVqb4GRPX4SQLeiPpOj5IOIx/Vz9AYvB9/VA6FbEvKacKfDbTkOBGP/5XXTF4lkFshMmA+YnNQSRk48NB3AGyG8IH3JqpHazyANwroauRHPBZ6Ef0hWAtyyQNVSXdw8aKMF8O1r0QmcJpzhHZjUg/WbM2UtkjI1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vkq3D8I6WqrsyhYzrBas6V74s58cS1Oijq74cTXSKm8=;
 b=HsY+Wgihh0NH9MF4CI6NZA7J5T2jqyISJFYnrNiVrrx0eYECIc+vlFsVeDX3g2+FHtyomVAr+v5JcWfnOEfOmeSkB5ho/ChIWdZTYY3hN5F0k+l0eOkZBs1/oN0XTD3+43vKXEpidPZei95p+icHygYd9+jdJUDebluZC/p+xDc=
Received: from OSZPR01MB8401.jpnprd01.prod.outlook.com (2603:1096:604:16f::7)
 by OSCPR01MB13378.jpnprd01.prod.outlook.com (2603:1096:604:32e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 12:47:51 +0000
Received: from OSZPR01MB8401.jpnprd01.prod.outlook.com
 ([fe80::c9a:aa8b:f8ea:998b]) by OSZPR01MB8401.jpnprd01.prod.outlook.com
 ([fe80::c9a:aa8b:f8ea:998b%5]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 12:47:51 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: lab-cip-renesas planned maintenance this Friday
Thread-Topic: lab-cip-renesas planned maintenance this Friday
Thread-Index: AdtRSwqPcaYpZoAjTv6ENBovlM7z/w==
Date: Wed, 18 Dec 2024 12:47:51 +0000
Message-ID: 
 <OSZPR01MB84013ECFC9A00534D77B756EB7052@OSZPR01MB8401.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8401:EE_|OSCPR01MB13378:EE_
x-ms-office365-filtering-correlation-id: a4a4c7a4-55b8-4fdf-6f33-08dd1f622f30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?TTe8yJ3GTuDGNioenyyLDrJPF1QWZ7363Wdfilbn1HnLoYr1csFlQ093Fg?=
 =?iso-8859-1?Q?dPd/nn00OBcAsMEsJDpNLPvG067ybrnzodwey/3N95HukPixelGCI7znEg?=
 =?iso-8859-1?Q?qSpGh9V0J78ucBo6rek72GTumBFOyMYXpL9DmXc0IOwqfYZYSXPrYelWWg?=
 =?iso-8859-1?Q?/88SykDye6Ly7kZPN2UMmLAPETeXLbruAVdNGZk6CLSg9PsMWH9ZF09L+z?=
 =?iso-8859-1?Q?ljPKYHGpO+bLt4QFIEozG31BljB7k1MRIrLnShPhwdI35rZ5g/S9P/FHob?=
 =?iso-8859-1?Q?zqpI58WIRr+Kf6VYC7F+HxQrYnWcqdAVDF3onBo0BDT/eS8kLxoo867W8y?=
 =?iso-8859-1?Q?iOlBerCa3Tv62Rmldfacn2OVASXvKrV8Et1Bri6DsAG83WIoQpm6vHobgd?=
 =?iso-8859-1?Q?5JQXscxRizx6WfImzSWJxUWQeMrRaTOEWH5lGqbgkBgnbWCu3drVpziRur?=
 =?iso-8859-1?Q?y5p41tucFvEZBXzHHwp6ePOllUJB0z2mAd23a8JRUTMAy03SXjw7xuETnQ?=
 =?iso-8859-1?Q?GUboxwL1KhGisMkYPXVQd6wjHxRoK7KJ18OG6NhGtF2uKgTpu5PA37chZU?=
 =?iso-8859-1?Q?OehWHhj240hfrN414ftSgARvVbZaMOI6ep26EYpUFvoOBEF2E+i/fWySXE?=
 =?iso-8859-1?Q?FHvbKmx0IWakPqiTyu/kSH0W0ZSC6MS+EjkGNiSeXNOmuEEyq+8g0GfdD5?=
 =?iso-8859-1?Q?cbxFNcuabwaPwvFL6xCTtP5QtCCMEk26CRvNb5/mEAxstbBTb9/BxGMolQ?=
 =?iso-8859-1?Q?ORtnW5LWMWgt9STIcoaG9X0iRn8lb/m4UA35Oih1UWSNyL96z7aOKBN0PZ?=
 =?iso-8859-1?Q?4ECEZzXtnDSBY9UzYEQusfny4kJY+ZJ5ZonQH1CoilwBTQ7gH9SCYAlE+n?=
 =?iso-8859-1?Q?2RZ6blrarmwZq163kwqLDzkdSLLr6Dlja/TQH1y7mTO+8ApTEcWVOt/mjQ?=
 =?iso-8859-1?Q?ioq5ai41l4sD3HXsraQlIAbW/lxOFrxFIqwRZsOEJfFLoJb4Vjxib3mCKZ?=
 =?iso-8859-1?Q?NRtkRQ5/gA0oO0xijJ5r9orpLH6GWlwWI0TH+UqYl2ZJTzBGsZ7XzEAQMT?=
 =?iso-8859-1?Q?IMu7DA70NVA/wM4Gf2Wgfj1cK929p9IOtg7W+NprJAvaGm/Efq3aS2u/IC?=
 =?iso-8859-1?Q?t/uj07C7pOti1rsHASH0hOJ9PA9BFjTp7kbu9IRlrPPr8bLfaLiokKjQZ/?=
 =?iso-8859-1?Q?u5zakP/6gHl2SDGl5cngylZhfLUX5/0R/12qrL76I7Quj1B3AfIJrm/qRA?=
 =?iso-8859-1?Q?EmPTd7djM5+4bx6shricNFTACdoq81vhxTYBA2V6NNuK0w1SNqaArje8Jd?=
 =?iso-8859-1?Q?U5vbhehMhvxwSA3WZIz/Bp7RzMRXUx8Vz89wm+g9YoA4CT4IoXIN4MoVup?=
 =?iso-8859-1?Q?4Mi8pjG+YuaMVQ27NXb6l9jbIzAv0fvXPUSsq700+Nod3nIIIF3X6TasOg?=
 =?iso-8859-1?Q?+/7DZ13B6FAnAQguVUvvJCJ0wNby8qg58GdDRzj1r8aFNYOF5ARU6WQJ87?=
 =?iso-8859-1?Q?GarDLNsgHm9lgG/opCYiBz?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8401.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?XXMlqgy0sriwyKJwDjyAPgsxhM5PAABYqBGeoIL+b7E6W+IjKpA70bIe7+?=
 =?iso-8859-1?Q?ALitPoJPZa25zm6omHWGgzk0/rQkAKPrXBAOWTN1lwNaZ47Xpb2moNjHhw?=
 =?iso-8859-1?Q?q2ev0roelepP8KbkAdE7aChGqqeAgkzMyQI1YsUknqsN2PhHTFpxx6zplr?=
 =?iso-8859-1?Q?b4g2Ol8GHsg+LptPyuNVlGwOyRvegyal8Tw6q11KFGZZ+PdL21YQKIBCrG?=
 =?iso-8859-1?Q?i4E7E/56ZLlKOnj+57J8E+3H55NoO5IGQhPjyVi1WnPlP97GHlcuwDcasK?=
 =?iso-8859-1?Q?HYrUhjSJo1RxMtMxkMbQ7gonSgyPQ4uB9v5AFHustp+2jYPc91rU9TmMkA?=
 =?iso-8859-1?Q?O6+NlSfjYrlPw5n8XuQqbQHcbtQpMrdBfZCKqa+02Mlk7h3DVlpa9GMN8W?=
 =?iso-8859-1?Q?/9VksucuKNpcBSVzZLcY0iFhRuGFvho8MFzKjECGQjtcOczF21yxMD7T3D?=
 =?iso-8859-1?Q?OMMt6OA+Fwh5kT17u8dOkdbeOYXckUelc+7DAjlVwfIQj6DGOW6/qF+0f0?=
 =?iso-8859-1?Q?cdoQoOJsMnx2NpW57ED0ps1N1cNIomCg/CLvjcT5FkIA1IxCkvEexPWGKp?=
 =?iso-8859-1?Q?6PZnycgRfdEhswMRMAz8GOYih5w7drCiMC7cAJlT8CCPM7I5TtxK70JND/?=
 =?iso-8859-1?Q?Q0AUa3W3KhK/n1yjXf8CgBIRwHQQp4nCqTb2FW4lWStYlHr5MzRNdqfLM1?=
 =?iso-8859-1?Q?RquiGiAnL9oHsl0Aqqb4qsvLItmeNNEKC85xiQkntX/XDj49chd2tPui4j?=
 =?iso-8859-1?Q?Ez0ZZemyUuTbguCSnDHK3o7Q37qDPQ4e3dXll9RuD0Hb3X3YZkgGN71pjN?=
 =?iso-8859-1?Q?7QMj3GC1KOV2Ki5c0dQEA6+Br17oS8pDbM2p6pdQCd4ImDIx8foZkLTLtK?=
 =?iso-8859-1?Q?AWenKlm0m477GsjRTaih6dODeNHc+nQ4vzmVheWLpcwObdae3hbEXndNB4?=
 =?iso-8859-1?Q?qWxRIQnha/qe3NBufi+Yk5SVml58TrKmYd8ilqNjK11XDFSBc5+WnjWPOR?=
 =?iso-8859-1?Q?a2SrIpavBWRp6tnNR/j4nEHnJy2qEB1fgJWPPYIsQLYOBtCa8l7dh0g3IZ?=
 =?iso-8859-1?Q?JMZaV7+DqHnu5Y3+KhYgJ6OxiVuAzzQ8rTV/fvKl7v/80pvc9/Z8HQsZsc?=
 =?iso-8859-1?Q?q3OG2Dk+5WeKXglIRyfoEY0JiGFFeSUdim9Yquj82wrlqhuNYCKqXE9gWE?=
 =?iso-8859-1?Q?Dfdyej0wIvjnGw1PrQgyN3VSPid27v/WDeEnAwZkCTswym2ypTxHepb0Fk?=
 =?iso-8859-1?Q?59D9lAlqgPtf9ftEEfz0ro9dAoljbW+AcmWyvp+ZcJtgmgoKxZ+0CfSfh9?=
 =?iso-8859-1?Q?Ej8I/nnLcs2RzgBe7wS7mV2pjEnp3gbjxGBpsq5HPStdo8HqcVEWr38NLm?=
 =?iso-8859-1?Q?z+RcVVkkYJ7gKvvdxXj+MBiYPqnB1/7av+hOOAHmhJQxzLHUL9polxqbAi?=
 =?iso-8859-1?Q?3lARcsSWX8+L7sgUDMGdQP/xIBfB1EOvFR/IK4/k3vveObpTQ8OkinNy/u?=
 =?iso-8859-1?Q?5wJ7hLSWwPf6EdCxToNgqhYcFodGTQprv6K2hEHkuz/jvoplell2trsj5z?=
 =?iso-8859-1?Q?tpGMtorYPFBcgx/X+i4sWmgApOG6wIhTevvzFwoST3bAhA1lT+j5+nWq9u?=
 =?iso-8859-1?Q?2zMHn2ZcLAdPt+3yeEWL9fKUujZ5QWMKy9p90qX/XySLjg6bEzGhT69w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8401.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a4c7a4-55b8-4fdf-6f33-08dd1f622f30
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 12:47:51.5337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FAoB2OK+jm2feNJn8tpuQ7oYjuGhPdAm6NU2xlsFdconwJf1E91e79b/aUwh63Z+tN6azWQx6P6n93zehkzWxjI5IbN+GbaF32aIsv3GZWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13378
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 12:48:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17464

Hi all,

Just a heads up that lab-cip-renesas will be offline for most of the day on=
 the 20th Dec as it's being moved to a new home.
Hopefully this won't cause any major issues.

Kind regards, Chris


