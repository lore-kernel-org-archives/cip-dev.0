Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E273D3F074
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 14:44:13 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.20])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14531.1769611451201158267
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Jan 2026 06:44:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=G7kL3QAa;
 spf=pass (domain: renesas.com, ip: 52.101.228.20, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBXRB9pAwQWidIwBeYY883tmE/KgaTfQLCdU8WvRpywLZcjchEDzIguXuJ6qwJN1msv3e9MKPVhl6MnQyhoiQdrN8hwxt34TBMvld92raoBBjNXUrKrcLGMq9+NZQqhqR/5BSXtOWP9Kj5GMi+ggDjf62SQ9rZKJfL5I8s2aeaBuj3efxtYOygG5SQ5N0QA9GTgHHg/C1gwqM23SifjWijbK2NW/87FBPBH6O3k3k9/KM53CACD2e8KwMz5BN1LOc6kylhPGYMmuETvOuWiUomoRgPH4QfXV9LbaxwxEMgFsJWJKaKs2KBSnjfiwfRwqn8zY6BO+YwzNAisGqtQMOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiQ9OA/oWKdzekyjklPVSGq+60JJlFrZKCdmOq+SKcc=;
 b=syVSDn9UIvx2iizVTvlC1FbloVcs02ImwUYGmsev4HTTjjF5z4AF0iBdLvWh1NES4wDX1eQ/61sK4vf8ZQ71iNKI2NoXdm1zhiHBAdiBzVqKcnhCrGz8HcpClUlPNQxqcAdJUPm21Ct4yG6CVmEqCImv649i4fGj8fOXJ54LtAHRUKj/Che3Ya8IlbcOYpobs8eaSjK2RowVncDbf6cbZCygxCos4W0VNAhhJEq1ZHE3F8kBmZxPbczWUSUgrJhUhoHNH40/3/2R5pQYAnos4BcfQXolA5SI3KhoqHyItmUh6vamlGP8wE7IfGha7oxJ4ocE1dLwhc7SAXPq0eviXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KiQ9OA/oWKdzekyjklPVSGq+60JJlFrZKCdmOq+SKcc=;
 b=G7kL3QAatmy7genr1LXAMFH83BF6HpeBY25McunQFqelRZhgIoypDrveM2m9JKr9FfE2YDUTVfqa0stPNMn4E7iCTL5pYK3FmPDw0h3DoEAGU6D88chYcqEqp5fhtAmsWzH5J++ARykYvCTLYTsX5qdp3UfEOahfcnh4vpdo7Dg=
Received: from TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:38d::6)
 by TY1P301MB0105.JPNP301.PROD.OUTLOOK.COM (2603:1096:400:2e6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 28 Jan
 2026 14:44:05 +0000
Received: from TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM
 ([fe80::961:aeb3:eb77:bd7d]) by TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM
 ([fe80::961:aeb3:eb77:bd7d%4]) with mapi id 15.20.9564.001; Wed, 28 Jan 2026
 14:44:05 +0000
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: Pavel Machek <pavel@nabladev.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip] thermal/drivers/renesas/rzg3s: Fix
 inverted reset logic in devm cleanup
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip] thermal/drivers/renesas/rzg3s: Fix
 inverted reset logic in devm cleanup
Thread-Index: AQHckGGUXBUEXPrds0y2MT821y2RMbVnqDTA
Date: Wed, 28 Jan 2026 14:44:05 +0000
Message-ID: 
 <TY7P301MB198409337DC544912D30751BD391A@TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM>
References: <20260128125840.6801-1-ovidiu.panait.rb@renesas.com>
 <aXobun68mrXuVr45@duo.ucw.cz>
In-Reply-To: <aXobun68mrXuVr45@duo.ucw.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7P301MB1984:EE_|TY1P301MB0105:EE_
x-ms-office365-filtering-correlation-id: 20c062f1-5473-4418-a846-08de5e7bafd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?A6eySlkK5FTuBMLITS/+pUJp7cj17/HiC3hMKKQFK9fsK/1OCoBsjqQVXN2f?=
 =?us-ascii?Q?qeuo6i/9INy17AmcDal0ELs+MTkk8BWYwE4Vl+mH6Z94/Dz0BqpY2ozr7042?=
 =?us-ascii?Q?8tEL2QHu7uBQunCLkf7fUfI5rsIiNaZrUoANU7MotkNWkEdqs5kodE87WK4q?=
 =?us-ascii?Q?1v5O4avBKWFO4sL9Ga/awhE2BP6VwzupUwojg0GC+D+vSRuLqXYmJjLfi2eA?=
 =?us-ascii?Q?/P4UwrOU499XxjaIpxL02hwbyF3LFIjpnSb4xgZYjiSH6HsIqesr2lFS6RPE?=
 =?us-ascii?Q?lei2u9EqrjBc84/s5aD79Ibt2ll4FwG+/5391TPgi55oKiRUPV9zTIY/NfEo?=
 =?us-ascii?Q?c+a5O3NIXOGorikhW7V4Kws/1vFoLEtTa0HSAejk4RZFLFZc4h48bDRR7N7j?=
 =?us-ascii?Q?Tsp9dj4nkTzpofJvuhURwxsKTznmj4nOhOqRk1JxwLjfMBbY6sNQwT+0dcN5?=
 =?us-ascii?Q?WTnU79xGU4dJTog0aaideqVupuzbo6v8EUcYTp/5ocU/D8Q+vmBnq+nc1TtV?=
 =?us-ascii?Q?0324N4qU7vi1ncz9Z9oaQx1tvWchPJZTeAx3D8c9+wUHj7h/6sdH4eHgUnyf?=
 =?us-ascii?Q?n9gue9GII6lNvoEmmE+svFyTi+G0qWDYJvM5e7iEdjZkIChCDNngMPo3IbbX?=
 =?us-ascii?Q?o8b9upocqawRcw8IPde7jiIMk0AS2wJGD64ZTLU75aK/BGbDhBnV+VZySlbt?=
 =?us-ascii?Q?YOUesCGfraTD9IQaA7radyPwaeihrWW91Pv6JGOeH3ngu9o6RldmURidwZyM?=
 =?us-ascii?Q?jljLYYVdN72W+ypskJuYDgx7pICjM2EVck5LtuSCztrt3LLC1KITtrOLJZY3?=
 =?us-ascii?Q?JJkkzt/5tYlI54curOJfV+o6K174AUE712vl1CMAzra/AceaAL4KAuccBq87?=
 =?us-ascii?Q?HFh1tgDnd7GT4wL0zZWe08P+wA91KbIdawP1h3tFi5Ph1q6i4p2Lzb3n1Kn8?=
 =?us-ascii?Q?j7A5pbwJIK8M43P3ZdYD8vU+bekPxm+HrQB5hnl+q/1GJzEhZvoc6T1iwDbo?=
 =?us-ascii?Q?deKXqewiRm2AqFEwpJhBNEF/Wa9lhyl9Z/QK+3L3+UhbetOTn7A4U+Y0F8Jc?=
 =?us-ascii?Q?tRE+ajm6sIfMWn2ALFJ2ecJS/AKMdia28vgaY6wKkkY4ejdQEKZFPNhdZjQH?=
 =?us-ascii?Q?NNCQm+hSg1bX90j8wpcXEY7b0aV8aMHh7KMG7GKBFOjfw5acdbDizf8ynlmP?=
 =?us-ascii?Q?m1lbgt8XYQux+hhc4LdXVUtZ5mYmFC4kLNGdl5kJ+3N56hZWPMvo9Nv/Ce6+?=
 =?us-ascii?Q?86zPQQzxaJJ7cL4ProBUGe/uT4LEuFGTmmNJpQlRs4mGiL9Dq1M1TCoQ/Io/?=
 =?us-ascii?Q?nAko1zTjjXxuHGZ3ac2LB+PiKEzZJVU6Mc9oyojpl65EyqSAB8HyxRzwftzz?=
 =?us-ascii?Q?pHi9C+zva2xgGIBGDqoOUdKLfvJhLzqEX7znfr9QfASr7TMltoBAknHSrJ1L?=
 =?us-ascii?Q?cIsvwrCJ5WJCETcoZDE+z3sriPFEG1YbCuybmAITpB/g6J+au3DkRdcfNtqt?=
 =?us-ascii?Q?J/CwY8MhW3TaG3f0EtjSv7pJ+4IxJCHWVz1ThdUmdUxzHshw+uxDiVfgjcHU?=
 =?us-ascii?Q?eMwUiQoFY8w3MyeWMdxrRVDdMOes82PZemmm1kPn41ISTQbNZhRV5Xa/MffM?=
 =?us-ascii?Q?tyPXjgJktW2QJ3vzGU0NfN0=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?iifMrZjbwkSSyq6ql8OBjncYrYnqb80YB01xSTgw9Q8b5EC14ocFPyNA+fhG?=
 =?us-ascii?Q?vFqYeh+qjQIy4XZqCo3bdwqb9obU0Xs84nx41hSAM+BtJue7Il/PJXCIuQuU?=
 =?us-ascii?Q?lq2jDrAM8apL8mWSiNHXTJv1zrPcBXj3oktvakLu6MMXercZXHwE4ihl7gqM?=
 =?us-ascii?Q?W6Csg9OMYxhGSRXVbMTmrPBLQfgp2WbIdKKozp2r/+eIzHzmC2QMmyvnd+oI?=
 =?us-ascii?Q?7zeNMwYxmF4/L5cqpC0BBlimQ8jVAjTW+cxhL+4KoaG9lKI2OYLUJFa1CBMd?=
 =?us-ascii?Q?+oSIJGTAtW+LFN/WDCh26KEizQkwSTX6duSMqoibdlGmm0A+g1EEsTn9Acs2?=
 =?us-ascii?Q?qgU32w6Jxxn81Wz+8Qio5yAw3kA7mKnw+B2ZSoC4J5upGlteqUhR2wIKSC8T?=
 =?us-ascii?Q?g6Qh5P9VCUcdFlDB5eCdAjkIw95CDLNsjq91Lah1MZVtQxas0ixR8rmsDf+P?=
 =?us-ascii?Q?HdblkPbmuCcegqXOhiT2HNy/f5ZE2R2FCpYskTfpuWbEoxueqvGX2hMBj1S5?=
 =?us-ascii?Q?wEKWY7y+RmxGQjJhf1kpBl7kO1uPGwuGW0Hm3E/71aXl6jHqBMvV5mwD4K27?=
 =?us-ascii?Q?i5/tt/lxcN9APSNutN1B7OM2xTihNyh0ekA34QsZnI8Kw3a14AJl6Cns1AjG?=
 =?us-ascii?Q?79/Scp65swNswkxp+cP8GWw8qt0KUe9jv9jcd391dnO2MM03yBOn5ZSSg2FQ?=
 =?us-ascii?Q?KfrZLosIkGD2h4GXXCUmCECFfdGZ1zen/UJQWpIAMatfdQxCTEzVfUxlUBbB?=
 =?us-ascii?Q?NCIGjal7+z4g48RJ3XgoTEsqDXa5cUX+MasOnqUmjVRl8BnGq588pEGlglov?=
 =?us-ascii?Q?Bz7woP1BIV7SlCb1zjTpxAj+uO2t+w4HA5PM+8uhtc2e7QhmQBz0aNbQ1KID?=
 =?us-ascii?Q?TPLCBgzECWkQxvW3F8UDCiDbWH0PmUVNfE/g+b/ZJ5JnnznOzLIItqLnoYoc?=
 =?us-ascii?Q?hEvPihpHWUmY+5AMZdrThCinmkaw9Jw0NhQ9pXW8edlo0AmgLn8lBOH76yrr?=
 =?us-ascii?Q?uOJjAU9w0b9KjL2Wos0G7yPeLdMfJjIRDTGA18SCgx/5V3CiD7TdueTS0Yse?=
 =?us-ascii?Q?l+eZ/PFZtD7QCX/A7oMzpoemBbDwQ3shouvzuxFjDIK9z2dKTON5O0/ipHO6?=
 =?us-ascii?Q?L+YYwW/78QxXjitkN599BOkYJUrHTJNOKz1O34iKECi1RxrT1AbsrdVCSWYr?=
 =?us-ascii?Q?WTu0VjoiSfYJiUMIXuXFzEnxvXA2e8f8rs4U+40dBKfYrwRbM//StdY2SZq1?=
 =?us-ascii?Q?BIWov2o4rtE7OVM08/U307cRagAEY5oXzLoiN6YEoMNFOp2bT78HT8sTiMiF?=
 =?us-ascii?Q?sX9UOdd2UV0mW4Nn1n+qokHGQm0p8XWR5CuG2c790r+sM2S6ZIgBTo7jFYDQ?=
 =?us-ascii?Q?CCBJU3QJMV973MZM9vVzhBxJkEprCaMQN/LJWu+7mNEtA1VXuicgQ4yEveDa?=
 =?us-ascii?Q?a2hMEaKp/Oqxc4rxPCW+6sLzRoPxQYLBt/rS9ZIv/VknPUpzX3Y+cF+aHGJi?=
 =?us-ascii?Q?1E244Yz9ieqZ/aLSB0U3sDkI7O/lcueTo+xIr/9LfikSVwWXV+PaHptgEUCq?=
 =?us-ascii?Q?u1aysB2idZkFsg/IpyG1r5fcil0Nw8qd8nTZ60VJAR5hFUmdA8i+BciTqP70?=
 =?us-ascii?Q?bdLNb/0W8zBiARuO7rQQ7wCiMdlWsq3gK7RQ1mwsFxuVlZ4RPY8SBqDVH+Ij?=
 =?us-ascii?Q?RU5/ndDA8ax4riFqKZS12IlQigq/VbX2marqptlsyyLLs1WbMaxTDz8uLKBi?=
 =?us-ascii?Q?2r4qyFPvJpwunsksJCMOaTs4AAe61R0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c062f1-5473-4418-a846-08de5e7bafd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 14:44:05.7030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PRUq4laYtyQOGJst/h9n2PiXEu2MBYB/FVfcXTlumD/1HcOq3j+iNODwSnCWE+6WvwgfvqQdN3qxTlJxas+zr4AaYIjkaXQ5VAyI9fdlbgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1P301MB0105
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Jan 2026 14:44:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21764

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Wednesday, January 28, 2026 4:23 PM
> To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> Cc: cip-dev@lists.cip-project.org; pavel@nabladev.com;
> nobuhiro.iwamatsu.x90@mail.toshiba
> Subject: Re: [cip-dev] [PATCH 6.1.y-cip] thermal/drivers/renesas/rzg3s:
> Fix inverted reset logic in devm cleanup
>=20
> Hi!
>=20
> > The devm reset callback that should undo the reset_control_deassert()
> done
> > during probe is incorrectly calling reset_control_deassert() again,
> > instead of reset_control_assert().
> >
> > Fix this by calling reset_control_assert() and rename the callback
> > function accordingly.
>=20
> Quick note here what if there is upstream equivalent or why not would
> be nice.
>=20
> I have my guesses, but...
>=20
> Thanks and best regards,
> 								Pavel
> --
> In cooperation with Nabla.

