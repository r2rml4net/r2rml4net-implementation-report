#!/usr/bin/env node

const { spawn } = require('child_process');
const clownface = require('clownface-io')
const namespace = require('@rdfjs/namespace')
const { rdf } = require('@tpluscode/rdf-ns-builders')

const ns = {
    doap: namespace('http://usefulinc.com/ns/doap#'),
    rdb2rdftest: namespace('http://purl.org/NET/rdb2rdf-test#')
}

async function main() {
    const { dataset } = await clownface().namedNode(`file:${__dirname}/test harness/ts.ttl`).fetch()

    clownface({ dataset }).has(rdf.type, ns.doap.Project).forEach(project => {
        const suffix = project.out(ns.doap.name).value
        const engine = project.out(ns.rdb2rdftest.dbms).value

        spawn('./run.sh', [
            '-s', suffix,
            '--engine', engine
        ], { stdio: 'inherit' })
    })
}

main()
