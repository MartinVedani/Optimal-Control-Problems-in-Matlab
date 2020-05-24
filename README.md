# Optimal-Control-Problems-in-Matlab

The problems were solved using DIDO©, a MATLAB® toolbox for solving optimal control problems.<sup>1</sup>  DIDO implements a guess-free,<sup>2</sup>  fast spectral algorithm based on pseudospectral optimal control theory.<sup> 3</sup>  In this approach, all functions are expanded in terms of an infinite series of special basis functions, and then truncated to a convergence tolerance.<sup>3</sup>  No knowledge of pseudospectral methods is necessary to use the software. Results from the widely-used <sup>4-6</sup>  toolbox are independently verifiable for feasibility and optimality. There are several techniques to verify the validity of a DIDO run; these are described in detail in [1].

– Input to DIDO is the problem formulation.

Input syntax: <code> dido(problem, algorythm) </code>

where <code> problem </code> defines the struture, bounds, and search space and <code> algorythm </code> is choosen by the user.

- Output of DIDO is a Pontryagin extremal.

Output syntax: <code> [cost, primal, dual] </code>

where <code> cost </code> is the variable to be minimized (or maximized multiplied by -1);
<code> primal, dual </code> are the candidate solutions and <code> dual </code> also serves to verify if the candidate solution satisfies Pontryagin's Principle. If they do not, then you certainly do not have an optimal solution. If they do, it does not mean you have an optimal solution (remember Pontryagin’s Principle is a necessary, not sufficient condition). What you have is an “extremal” (candidate optimal).

References:

[1] Ross, I. M., A Primer on Pontryagin’s Principle in Optimal Control, Second Edition, Collegiate Publishers, San Francisco, 2015, Section 3.2.

[2] Ross, I. M. and Gong, Q., “Guess-Free Trajectory Optimization,” AIAA/AAS Astrodynamics Specialist Conference and Exhibit, Honolulu, HI, August 18-21, 2008. AIAA 2008-6273.

[3] Ross, I. M. and Karpenko, M., “A Review of Pseudospectral Optimal Control: From Theory to Flight,” Annual Reviews in Control, Vol.36, 2012, pp.182-197.

[4] Bedrossian, N., Karpenko, M. and Bhatt, S. “Overclock My Satellite: Sophisticated Algorithms Boost Satellite Performance on the Cheap,” IEEE Spectrum, November 2012.

[5] Conway, B. A.., “A Survey of Methods Available for the Numerical Optimization of Continuous Dynamic Systems,” Journal of Optimization Theory and Applications, Vol.152, No. 2, 2012, pp. 271-306.

[6] Gong, Q., Kang, W., Bedrossian, N. S., Fahroo, F., Sekhavat, P., Bollino, K., "Pseudospectral Optimal Control for Military and Industrial Applications,“ Proceedings of the 46th IEEE Conference on Decision and Control, 2007, pp. 4128–42.
