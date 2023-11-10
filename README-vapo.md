This is a modified branch customized for VAPO environment.
We do not need to create all the operators since they will be provided by VAPO.
The only dedicated namespace we have access to is daybreak-*
We will only deploy sealed-secretes, and argo instance. We will no longer need to run most of other bootstrap scripts.
To setup for VAPO, run

`cd bootstrap/overlays/vapo`

`oc apply -k .`