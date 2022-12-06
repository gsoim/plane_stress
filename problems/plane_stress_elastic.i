[GlobalParams]
    displacements = 'disp_x disp_y'
    out_of_plane_strain = strain_zz
[]

[Mesh]
    type = GeneratedMesh
    elem_type = QUAD4
    dim = 2
    nx = 50
    ny = 50
    xmin = 0
    xmax = 3
    ymin = 0
    ymax = 3
[]

[Variables]
    [disp_x]
        order = FIRST
        family = LAGRANGE
    []
    [disp_y]
        order = FIRST
        family = LAGRANGE
    []
    [strain_zz]
    []
[]

[AuxVariables]
    [stress_xx]
        order = CONSTANT
        family = MONOMIAL
    []
    [stress_xy]
        order = CONSTANT
        family = MONOMIAL
    []
    [stress_yy]
        order = CONSTANT
        family = MONOMIAL
    []
    [strain_xx]
        order = CONSTANT
        family = MONOMIAL
    []
    [strain_xy]
        order = CONSTANT
        family = MONOMIAL
    []
    [strain_yy]
        order = CONSTANT
        family = MONOMIAL
    []
    [nl_strain_zz]
        order = CONSTANT
        family = MONOMIAL
    []
    [vm_stress]
        order = CONSTANT
        family = MONOMIAL
    []
[]

[AuxKernels]
    [stress_xx]
        type = RankTwoAux
        rank_two_tensor = stress
        variable = stress_xx
        index_i = 0
        index_j = 0
    []
    [stress_xy]
        type = RankTwoAux
        rank_two_tensor = stress
        variable = stress_xy
        index_i = 0
        index_j = 1
    []
    [stress_yy]
        type = RankTwoAux
        rank_two_tensor = stress
        variable = stress_yy
        index_i = 1
        index_j = 1
    []
    [strain_xx]
        type = RankTwoAux
        rank_two_tensor = total_strain
        variable = strain_xx
        index_i = 0
        index_j = 0
    []
    [strain_xy]
        type = RankTwoAux
        rank_two_tensor = total_strain
        variable = strain_xy
        index_i = 0
        index_j = 1
    []
    [strain_yy]
        type = RankTwoAux
        rank_two_tensor = total_strain
        variable = strain_yy
        index_i = 1
        index_j = 1
    []
    [strain_zz]
        type = RankTwoAux
        rank_two_tensor = total_strain
        variable = nl_strain_zz
        index_i = 2
        index_j = 2
    []
    [stress_vm]
        type = RankTwoScalarAux
        rank_two_tensor = stress
        variable = vm_stress
        scalar_type = VonMisesStress
    []
[]

[Modules/TensorMechanics/Master]
    [./block1]
        planar_formulation = WEAK_PLANE_STRESS
        strain = SMALL
        add_variables = true
    [../]
[]

[BCs]
    [fix_x]
        type = DirichletBC
        preset = true
        variable = disp_x
        boundary = 'left right'
        value = 0.0
    []
    [fix_y]
        type = DirichletBC
        preset = true
        variable = disp_y
        boundary = 'left right'
        value = 0.0
    []
    [top]
        type = DirichletBC
        variable = disp_y
        boundary = top_node
        value = -1
    []
[]

[Materials]
    [./elasticity_tensor]
        type = ComputeIsotropicElasticityTensor
        youngs_modulus = 210000.0
        poissons_ratio = 0.3
    [../]
    [./stress]
        type = ComputeLinearElasticStress
    [../]
[]

[Executioner]
    type = Steady
    solve_type = 'NEWTON'
[]

[Outputs]
    perf_graph = true
    [vtk]
        type = VTK
        use_displaced = true
        interval = 1
    []
[]