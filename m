Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89E4EB64DC
	for <webhook@archiver.kernel.org>; Mon, 17 Jul 2023 08:26:25 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.103])
 by mx.groups.io with SMTP id smtpd.web10.3724.1689582381973414518
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Jul 2023 01:26:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=pbykTW2J;
 spf=pass (domain: renesas.com, ip: 40.107.114.103, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqL9zYaQqtp9Z95kQl+gsrLVqGjgpaKj12GvWTB8Vz2NPI8mbVkk2dv+4EvsFQj1xIVgGikAShE+2V69XAzslrn9rpZgs1lrggU4wVMz4WU+km1NL9JaRmi1hMb1WExiDEW2G6EdLu7DuCsKNKuoMC0EFPJWupv8drW6KjuZ3mlykIvTYSZMo/XS0dD6N8C4nZA6K9IBOpcwYvi3QscliTe1lmXZq1n6xuENIr9iBQoezLibNcbODLH5N1Itmm6fRWTQSLTXDU2AZo0GJ2BT6JFZZrtHH289qUckWiDgzz3RAdt8I2mbdq6sk6gID+OFyG+bmvytsCj4C8JwTBD7fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQg4/G48UTKs7NwDiooTAxNZmQCmLuGO+qM6f/GLOAw=;
 b=ALQiS9dtoptDvZriTRd474lPC4UP7Ndc7dBFNE59MGD5Sl4uIVNa4DMngPFOhbX7Thn7Jhydn+74QWW2PTpufhhlxEM6zI1N29bIu8Wtng9dYPMRBe8Q1r483fLZC9naUvLaJcVmP6aCYTl0d+mCA4ERlMSxpeBnR5OTFMV04L+ejV5s/inM6Vhv6IK6TCUzyxDc+CMznaf95bNksvFhq8hkqdoHOsHQSQsyldC5GyQtuTTnj3AO2qZm6h8rvt52nsmmdnjiho3D7CtfELEhM79q7E2QpRVZV2DQODgXi/ubQ/ydbhdZXhbN0M7a14iOCw1cnZuCK7iVONCtdyP+Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQg4/G48UTKs7NwDiooTAxNZmQCmLuGO+qM6f/GLOAw=;
 b=pbykTW2JXjTINOqhFl17CTRvos57PEhmN1NoJ31CRkJ3Fm5d8drXG9Fswv17rLosWcnQfHVszF8NcDIDyy7luKiYpS5myj4YL7CFAQsQQcoHRZD0HABYhfj9gp0jfFIV4Cz9FV4xZAlsw3N1ExnHLX0BJDZkGHxd1vPOSukwK2s=
Received: from OSBPR01MB3783.jpnprd01.prod.outlook.com (2603:1096:604:43::11)
 by TYWPR01MB12061.jpnprd01.prod.outlook.com (2603:1096:400:447::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 08:26:17 +0000
Received: from OSBPR01MB3783.jpnprd01.prod.outlook.com
 ([fe80::f871:5f26:6e33:4e36]) by OSBPR01MB3783.jpnprd01.prod.outlook.com
 ([fe80::f871:5f26:6e33:4e36%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 08:26:13 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "jan.kiszka@siemens.com"
	<jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: Releasing 6.1-cip-rt?
Thread-Topic: Releasing 6.1-cip-rt?
Thread-Index: AQHZt8mD/rf+JKVA40elyVZp5xoBWq+9nong
Date: Mon, 17 Jul 2023 08:26:13 +0000
Message-ID: 
 <OSBPR01MB37832E29568216DA98CC7E3FB73BA@OSBPR01MB3783.jpnprd01.prod.outlook.com>
References: <ZLO69J9ZmUBl3+cy@duo.ucw.cz>
In-Reply-To: <ZLO69J9ZmUBl3+cy@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSBPR01MB3783:EE_|TYWPR01MB12061:EE_
x-ms-office365-filtering-correlation-id: e8414fe2-b312-4f73-6304-08db869f7bbb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 4YNuv4n9TpW+K7qp9uo39QL+dUPb15nvBPzKBdrbekjHpSK+KB2FkgMRD5Gu29ZbyntMnPVbBYK70pfaQmc3SnstcEFzBhVSTM0T7DAsw+1QuoQpX4Xl4AbeMrJ7iPy3+zhjSOJsI0O2Y6+LP512BX+hzCozBVRHgUlQRkfjwhBcosQ+agKHW34vHCYWBmzCcL1YH3DUq7c8iLHK8eiNeNn/MPR2idEe7PoCWlz9EbnxnrslaSREF9U4a6j0IbJ9la2pYFcPQzXGVBMm9/+Gf+qiWHR7GGZ+mvbuWW+6rZdj9NXvsLAvrrmhCsgjhgWAJzITuiy+T43zX3rqDWqLVuXmAABCxN0ufhQHRqQLjW/ybh0CDJS3gkQFEXg9wblo5YjliuAR38RcxirJ749/SQJhD03dsBmaCklaNhzi6ltT6qdFOfAfy1fRgXP9n/KCRchy+qoLAPuzODbboMa2rHcNa4oRELWahoEHXUWgeV8m/LyxTByQklhZjuh5LUykNLSyY6z4A7ak47fwOsGwF1RYmEns4OW+nU5NlGhoj0A7MuHNpbnfcOdE0YlkAxDrA2CRk+Ixigpb9vq7CdYLPFzOELP0aTBbgbTPMvtXdxvDTMS2ZhV/KU8CWjf7PPk7Fh+brSIvTlqOKvxDvwsnpw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB3783.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199021)(478600001)(66556008)(66446008)(64756008)(66476007)(66946007)(5660300002)(52536014)(76116006)(316002)(8676002)(8936002)(55016003)(2906002)(41300700001)(71200400001)(110136005)(966005)(6506007)(26005)(9686003)(7696005)(33656002)(38100700002)(186003)(83380400001)(122000001)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?FNXVBRPj1a63W8XSxpq0eD8Xaby3YcqrHIoG8ac8xrkYsO7lXTbYlBgS?=
 =?Windows-1252?Q?NwwDg1WypdEcVyjTk/PupM7KyIG1Q0dcAvTczPbnfsjb9u4U62EshpxH?=
 =?Windows-1252?Q?EadrnhamamrBmwEu0nzc3ba4ZWG48iWLGydZE1qXfJ4umO3I+hGIoau9?=
 =?Windows-1252?Q?b1xGVT2Ir3T6OJvfr67FKhilFj48wBaYDQLkuOX+vPGEC5/+GQTmHoKl?=
 =?Windows-1252?Q?hUahHISDTE7LOpptGkG4q77IICTfIgQhWUGPjVNtAL/2pVCMS81UAGhc?=
 =?Windows-1252?Q?2H0NWskWwzXu4EXLJSn+IIZIdgSmjE9vXZ7XKR1ejXZdcrqJVpU0uDrs?=
 =?Windows-1252?Q?FFN4xXixHH3VxUF3PDsKN3z0sY4QjH21VcQFoZ8miaEg7FsKWX5UF1Gf?=
 =?Windows-1252?Q?uTUDelZNI7qOF1479OhL6umScsIzPAZsPaeQQBj8meJrBe+Qgo+K7BZ3?=
 =?Windows-1252?Q?N6WGNM4O9Gc1gpbZyRxTBXyK8YdW3nB+1/WlPpyTSaHK6zUaGq6U4YHD?=
 =?Windows-1252?Q?33RF+CLIKchq7jfcahhyKEkLsXN4KgYZI1EFuW6UeEyCVgW47de9khf5?=
 =?Windows-1252?Q?IzH2an032EgXoVw98Zb73Tua2t2u9A50u3rSWja6MUQOACG4L5ZVO4LN?=
 =?Windows-1252?Q?EZw65z/qylZfJqhnESt1LIKuERMRR0gc4idvVb/TT1gvM5OD/6hM6fwQ?=
 =?Windows-1252?Q?Rpqwrh9muIxTd5A7Dd5RPi+wVVznrTBab+eIyw3BncNeHRndNSzLj9yN?=
 =?Windows-1252?Q?C1W+7Qt/c9/hxvecrkvKF/pwf8B6Iyogxy0CgSRjzXb9HchI8+wVQYFM?=
 =?Windows-1252?Q?bpKrHnr4M4PMtnRsMvuGlBYf+0k7uRg+pjg+6Lys+ZMBAHDCRu0TMaU/?=
 =?Windows-1252?Q?EsWLSpTfxF+RBKkOqsDjoHkwN9V4gbdjw/Zg3RHsnPg4QtnDhZDHJJld?=
 =?Windows-1252?Q?km4XSK96xGblkXcLKc+N5ulYXsQWbwsKcruR0SObh+tKY8j0BrY/27dk?=
 =?Windows-1252?Q?qzur5ed5MSrDhcpRsRilIe0DHLgj0wvHNBFdjiqMR7pZm33kxfMiyP+/?=
 =?Windows-1252?Q?gdF6In1Y9/cjr2p5iwGH9y++7k45i0/xhfKPLPkRsYRM//x7cN/1V9CH?=
 =?Windows-1252?Q?8Jw3+7qcl0rwEA2cTTdU+Il6vaxp+NM9erYuopHaffd5g54qs/uVbpD+?=
 =?Windows-1252?Q?+Z70bhlNi65xNwxjMYd7B3tsQN7T6hExpiUF1D1wND3UjARBdYWtChAN?=
 =?Windows-1252?Q?UZut3nNQBsXKeITnB2wSxzHSWzOsRV4+WY79CceNSUYED4fT+M67i/Qh?=
 =?Windows-1252?Q?TG9Kk1QWWrogto05wZF0wxWUysHNRVKKsOZcef+LBnqXnoP0BC2Ozt/m?=
 =?Windows-1252?Q?9BhJAQr+EziimPn5sCBRsOkTkKgS3qOslOHa2XiJonAcImdVsxjlbZQ6?=
 =?Windows-1252?Q?J+h1GTpCy9HDvJCga2J3DQzDIn2j1XpDttr6hDMGvlRUFMI/KRNmmNmS?=
 =?Windows-1252?Q?pKMvAkCgDCEdIFzryB5M9mLfPok5g8WO3atjnOY0o37gdbuVq4612DlW?=
 =?Windows-1252?Q?1sxfVoJ4WaA9qVKuYePifOr3L1lAuH3LWmVhkckLq3lLNMU0j3cu/j7+?=
 =?Windows-1252?Q?oeZUq1K6fL9H2yY5H6pmCbR1RORTxbN1pqEWE51JLqDIWuStL1uNAdvF?=
 =?Windows-1252?Q?jS6ODvkoki9XhpaxwdGzZgD6RlkkFyFqwi59HI2nL5H+nazdYdXvow?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB3783.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8414fe2-b312-4f73-6304-08db869f7bbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2023 08:26:13.6236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WLRJtnCJ05XnoTK3XCr3I8PC3FcSqB8AAZv9CP9KGOAfS121Y2AMmSla6SLqfhd53w6eE+13vlShyxf1HyI8OO4iBw89PSrcomkWMqA9ct4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB12061
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Jul 2023 08:26:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12365

Hello Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: Sunday, July 16, 2023 10:40 AM
>=20
> Hi!
>=20
> I prepared simple merge of 6.1.38-cip1 with 6.1.38-rtrt12, and seems
> to pass basic testing.
>=20
> https://gitlab.com/cip-project/cip-kernel/linux-cip/tree/ci/pavel/linux-t=
est

Looking at the CI you're running here, builds with RT configurations and th=
e RT tests we support aren't actually being run.
Our pipelines currently look at the name of the branch [0] to determine whe=
ther RT builds/tests are run.
Specifically, *linux-6.1.y-cip-rt. So for dev testing with RT you'd need to=
 use a branch like ci/pavel/linux-6.1.y-cip-rt.
If you want to keep using the single ci/pavel/linux-test, we could update t=
he pipelines to also run RT testing on ci/pavel/linux-test, but then they w=
ould also run on any non-RT kernels you push.
Alternatively we could add some variables into the .gitlab-ci.yml file to s=
tate that RT tests should be run, but we were trying to keep the .gitlab-ci=
.yml file the same throughout branches.

[0] e.g. https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-/b=
lob/master/trees/linux-6.1.y-cip.yml#L147

Kind regards, Chris

>=20
> If there are reasons not to release this, or extra steps that should
> be taken here, let me know.
>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

